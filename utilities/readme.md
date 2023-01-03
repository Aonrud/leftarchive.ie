Template Utilities 
-----

Utlities should follow this naming convention:

|Filename|Description|
|---|---|
|entry[-`<name>`]|Generic templates useful for entries from multiple sections with overlapping data models.|
|section|Section templates for all sections - generally returns URLs, icons etc.|
|section-`<section-name>`|Templates for a section which can be called on multiple pages in the same way.|
|section-`<section-name>`-`<name>`|Purpose-specific section templates separated from main section one for convenience.|
|metadata-`<type>`|Metadata templates.|
|layout-`<name>`|Templates that contain layout or page design elements.|
|page-`<page-name>`-`<name>`|Templates only used on a specific page, but cut out into a utility for easier management.|
|general-`<name>`|General XSL utilities, strings, language features etc.|
|field-`<name>`|Templates for specific fields. Not used in page templates, but to generate fields in the database.|
