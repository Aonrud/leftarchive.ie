<?php

class eventstory extends SectionEvent
{
    public $ROOTELEMENT = 'story';

    public $eParamFILTERS = array(
        'xss-fail'
    );

    public static function about()
    {
        return array(
            'name' => 'Story',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2020-10-07T09:46:12+00:00',
            'trigger-condition' => 'action[story]'
        );
    }

    public static function getSource()
    {
        return '42';
    }

    public static function allowEditorToParse()
    {
        return true;
    }

    public static function documentation()
    {
        return '
                <h3>Success and Failure XML Examples</h3>
                <p>When saved successfully, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;story result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/story></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;story result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/story></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;story result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/story></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="31457280" />
    &lt;label>Name
        &lt;input name="fields[name]" type="text" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;label>Notes
        &lt;textarea name="fields[notes]" rows="30" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;input name="fields[associations]" type="hidden" value="…" />
    &lt;label>Date
        &lt;input name="fields[date]" type="text" />
    &lt;/label>
    &lt;input name="action[story]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="https://www.leftarchive.ie/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['story'])) {
            return $this->__trigger();
        }
    }

}
