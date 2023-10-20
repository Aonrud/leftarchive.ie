<?php

class eventsubmit_comment extends SectionEvent
{
    public $ROOTELEMENT = 'submit-comment';

    public $eParamFILTERS = array(
        'akismet',
        'xss-fail'
    );

    public static function about()
    {
        return array(
            'name' => 'Submit Comment',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://dev.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-11-12T14:09:21+00:00',
            'trigger-condition' => 'action[submit-comment]'
        );
    }

    public static function getSource()
    {
        return '9';
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
                <pre class="XML"><code>&lt;submit-comment result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/submit-comment></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;submit-comment result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/submit-comment></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;submit-comment result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/submit-comment></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="62914560" />
    &lt;label>Title
        &lt;input name="fields[title]" type="text" />
    &lt;/label>
    &lt;label>Comment
        &lt;textarea name="fields[comment]" rows="15" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;label>Name
        &lt;input name="fields[name]" type="text" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;label>Website
        &lt;input name="fields[website]" type="text" />
    &lt;/label>
    &lt;label>Date
        &lt;input name="fields[date]" type="text" />
    &lt;/label>
    &lt;input name="fields[associated-page]" type="hidden" value="…" />
    &lt;label>Published
        &lt;input name="fields[published]" type="checkbox" value="yes" checked="checked" />
    &lt;/label>
    &lt;input name="fields[parent]" type="hidden" value="…" />
    &lt;input name="action[submit-comment]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="https://dev.leftarchive.ie/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['submit-comment'])) {
            return $this->__trigger();
        }
    }

}
