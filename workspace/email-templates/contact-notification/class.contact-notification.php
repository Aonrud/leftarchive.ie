<?php

class Contact_notificationEmailTemplate extends EmailTemplate
{
    public $datasources = array(
        'submission',
    );
    public $layouts = array(
        'plain' => 'template.plain.xsl',
    );
    public $subject = 'ILA Contact: {/data/submission/entry/subject}';
    public $from_name = 'Irish Left Archive';
    public $from_email_address = 'contact@leftarchive.ie';
    public $reply_to_name = '{/data/submission/entry/name}';
    public $reply_to_email_address = '{/data/submission/entry/email}';
    public $recipients = 'email-recipient';
    public $attachments = '/workspace{/data/submission/entry/document/@path}/{/data/submission/entry/document/filename}';
    public $ignore_attachment_errors = true;

    public $editable = true;

    public $about = array(
        'name' => 'Contact Notification',
        'version' => '1.0',
        'author' => array(
            'name' => 'Aonrud',
            'website' => 'https://www.leftarchive.ie',
            'email' => 'admin@leftarchive.ie'
        ),
        'release-date' => '2020-04-24T09:01:37+00:00'
    );
}
