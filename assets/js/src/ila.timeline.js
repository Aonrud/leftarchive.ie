/**
 * Class for applying dynamically loaded popovers
 * @depends Tippy.js, & :. popper.js
 * @param elements The elements to apply the popover to
 * @param type The section to request dynamic info for (i.e. organisation, publication etc.)
 */
class PopoverWrapper {
	
	constructor(elements, type) {
		this._type = type;
		const wrapInstance = this;
		
		for (const element of elements) {
			element.classList.add("entry-popover");
		}
		
		tippy('[data-ila-id]', {
			content: 'Loading...',
			allowHTML: true,
			interactive: true,
			trigger: 'click',
			placement: 'auto',
			onShow(instance) {
				wrapInstance._getPopoverContents(instance.reference)
				.then(content => instance.setContent(content))
				.catch((e) => {
					console.log(`Error loading info for ${instance.reference.id}: ${e}`);
				});
				_paq.push(['trackEvent', 'Timeline', 'Popover', instance.reference.innerText]);
			}
		});
	}
	
	_getPopoverContents(element) {
		const id = element.dataset.ilaId;			
		return this._getXml(id)
				.then( xml => {
					const imgLoaded = this._loadImage(xml);
					const html = this._popoverTemplate(xml);
					return Promise.all([imgLoaded, html]);
				})
				.then( data => data[1] );
	}
	
	_popoverTemplate(xml) {
		const name = xml.querySelector("name").textContent;
		const published = (xml.querySelector("published") !== null ? xml.querySelector("published").textContent !== "false" : true);
		const description = xml.querySelector("description").innerHTML;
		const link = xml.querySelector("link").textContent;
		const others = this._popoverTemplateOthers(xml.querySelector("minors"));
		
		let img = xml.querySelector("image");
		img = (img ? `<img src="${img.textContent}" class="timeline-image" />` : '');
		
		
		const iconMap = { 
			'years': '<span class="fas fa-calendar"></span>', 
			'publisher': '<span class="fas fa-users"></span>'
		}
		let listInfo = '';
		
		for (const item of xml.querySelectorAll("listInfo item")) {
			const icon = ( iconMap[item.querySelector("name").textContent] ? iconMap[item.querySelector("name").textContent] : '' );
			const value = item.querySelector("value").textContent;
			listInfo += `<li>${icon} ${value}</li>`;
		}
		
		let html = `<h3>${name}</h3>
					${img}
					<ul class="list-unstyled">${listInfo}</ul>
					${others}`;
		html += ( published ? `<p><strong><a href="${link}">${name} in the archive <span class="fas fa-angle-double-right"></span></a></strong></p>` : '');
		html += `<div>${description}</div>`;
		
		return html;
	}
	
	_popoverTemplateOthers(minors) {
		if(!minors) return "";
		let others = `<p>Other names:</p><ul>`;
		for (const entry of minors.querySelectorAll("entry")) {
			others += `<li>${entry.querySelector("name").textContent} ${entry.querySelector("years").textContent}</li>`;
		}
		others += `</ul>`;
		return others;
	}
	
	_loadImage(xml) {
		const src = (xml.querySelector("image") ? xml.querySelector("image").textContent : "");
		return new Promise(resolve => {
			const img = new Image();
			img.onload = () => resolve();
			img.onerror = () => resolve();
			img.src = src;
		});
	}
		
	_getXml(id) {
		const url = `/dynamic/${this._type}/${id}/`;
		return fetch(url)
				.then(response => response.text())
				.then(str => new DOMParser().parseFromString(str, "text/xml"));
	}
}

/** Basic show/hide animation class.
 * Depends on CSS classes.
 */
class Toggler {
	
	constructor(source, toggledText = "") {
		this._source = source;
		this._toggledText = toggledText;
		this._origText = source.textContent;
		this._target = document.getElementById(source.dataset.toggleTarget);
		if(this._target == null) throw new Error(`Invalid target ${source.dataset.toggleTarget}`);
		this._source.addEventListener("click", () => this.toggle() );
	}
	
	toggle() {
		if (this._target.classList.contains('visible')) {
			this.hide();
			return;
		}
		this.show();
	}
	
	show() {
		const target = this._target;
		const height = this._checkHeight(target);
		
		this._source.classList.remove("collapsed");
		if (this._toggledText) this._source.querySelector(".button-text").textContent = this._toggledText;
		
		target.classList.add("visible");
		target.style.height = height;
		
		setTimeout( () => target.style.height = '', 250);
	}
	
	hide() {
		const target = this._target;
		
		this._source.classList.add("collapsed");
		if (this._toggledText) this._source.querySelector(".button-text").textContent = this._origText;
		
		target.style.height = target.scrollHeight + "px";
		setTimeout( () => target.style.height = 0, 1);
		setTimeout( () => target.classList.remove("visible"), 250);
	}
	
	_checkHeight(el) {
		el.style.display = 'block';
		const h = el.scrollHeight + "px";
		el.style.display = '';
		return h;
	}
}
