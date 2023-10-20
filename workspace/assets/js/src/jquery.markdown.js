/**
 * 
 * jquery-markdown 1.0
 * @author Can Geliş
 * @license License file must be attached with the source code (MIT License)
 * 
 */
$.fn.textReplace = function(options) {
    var settings = $.extend({
        selected: function() {
            return "";
        },
        no_selection: function() {
            return "";
        }
    }, options);
    var textarea = this, actual = this.get(0);
    var selectionStart = actual.selectionStart, selectionEnd = actual.selectionEnd;
    var text_to_replace = $(textarea).val().substring(selectionStart, selectionEnd);
    if (selectionStart === selectionEnd) {
        value = $(textarea).val() + settings.no_selection();
    } else {
        value = $(textarea).val().substring(0, selectionStart) +
                settings.selected(text_to_replace) +
                $(textarea).val().substring(selectionEnd);
    }
    $(textarea).val(value);
};
String.prototype.repeat = function(num)
{
    return new Array(num + 1).join(this);
};
$.fn.mdBold = function(options) {
    var settings = $.extend({
        defaultVal: "Bold Text Here"
    }, options);
    $(this).textReplace({
        selected: function(text) {
            return "**" + text + "**";
        },
        no_selection: function() {
            return "**" + settings.defaultVal + "**";
        }
    });
};
$.fn.mdItalic = function(options) {
    var settings = $.extend({
        defaultVal: "Italic Text Here"
    }, options);
    $(this).textReplace({
        selected: function(text) {
            return "_" + text + "_";
        },
        no_selection: function() {
            return "_" + settings.defaultVal + "_";
        }
    });
};
$.fn.mdHeader = function(options) {
    var settings = $.extend({
        defaultVal: "Heading Here",
        number: 1
    }, options);
    $(this).textReplace({
        selected: function(text) {
            return '\n' + "#".repeat(settings.number) + " " + text + '\n\n';
        },
        no_selection: function() {
            return '\n' + "#".repeat(settings.number) + " " + settings.defaultVal + '\n\n';
        }
    });
};
$.fn.mdLink = function(options) {
    var settings = $.extend({
        defaultVal_text: "Link Text Here",
        defaultVal_url: "URL Here"
    }, options);
    $(this).textReplace({
        selected: function(text) {
            return '[' + text + '](' + settings.defaultVal_url + ')';
        },
        no_selection: function() {
            return '[' + settings.defaultVal_text + '](' + settings.defaultVal_url + ')';
        }
    });
};
$.fn.mdImage = function(options) {
    var settings = $.extend({
        defaultVal_alt_text: "",
        defaultVal_image_url: "Image URL Here",
        defaultVal_image_title: ""
    }, options);
    $(this).textReplace({
        selected: function(image_link) {
            return '![' + settings.defaultVal_alt_text + '](' + image_link + ' "' + settings.defaultVal_image_title + '")';
        },
        no_selection: function() {
            return '![' + settings.defaultVal_alt_text + '](' + settings.defaultVal_image_url + ' "' + settings.defaultVal_image_title + '")';
        }
    });
};
$.fn.mdCode = function(options) {
    var settings = $.extend({
        defaultVal: "Code here"
    }, options);
    $(this).textReplace({
        selected: function(code) {
            lines = code.split('\n');
            if (lines.length === 1) {
                return '`' + code + '`';
            } else {
                final_code = "";
                for (i = 0; i < lines.length; i++) {
                    final_code += "    " + lines[i] + '\n';
                }
                return final_code;
            }
        },
        no_selection: function() {
            return '`' + settings.defaultVal + '`';
        }
    });
};
$.fn.mdQuote = function(options) {
    var settings = $.extend({
        defaultVal: "Quote here"
    }, options);
    $(this).textReplace({
        selected: function(code) {
            lines = code.split('\n');
            if (lines.length === 1) {
                return '\n> ' + code + '\n';
            } else {
                final_code = "\n";
                for (i = 0; i < lines.length; i++) {
                    final_code += "> " + lines[i] + '\n';
                }
                return final_code;
            }
        },
        no_selection: function() {
            return '\n> ' + settings.defaultVal + '\n';
        }
    });
};
$.fn.mdNumberedList = function(options) {
    var settings = $.extend({
        defaultVal: "List item"
    }, options);
    $(this).textReplace({
        selected: function(code) {
            lines = code.split('\n');
            if (lines.length === 1) {
                return '1. ' + code + '\n';
            } else {
                final_code = "\n";
                for (i = 0; i < lines.length; i++) {
                    final_code += (i+1)+". " + lines[i] + '\n';
                }
                return final_code;
            }
        },
        no_selection: function() {
            return '1. ' + settings.defaultVal + '\n';
        }
    });
};
$.fn.mdBulletList = function(options) {
    var settings = $.extend({
        defaultVal: "List item"
    }, options);
    $(this).textReplace({
        selected: function(code) {
            lines = code.split('\n');
            if (lines.length === 1) {
                return '- ' + code + '\n';
            } else {
                final_code = "\n";
                for (i = 0; i < lines.length; i++) {
                    final_code += "- " + lines[i] + '\n';
                }
                return final_code;
            }
        },
        no_selection: function() {
            return '- ' + settings.defaultVal + '\n';
        }
    });
};