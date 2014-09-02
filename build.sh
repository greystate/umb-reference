DOCSET_NAME="Umbraco Library Quick Reference"
ARCHIVE_NAME="Umbraco_Library_Quick_Reference"
BUNDLE="dist/$DOCSET_NAME.docset"
EXPORTED_FILE="umbraco.library.xml"
DOC_XML_FILE="extensions.xml"
FEED_FILENAME="umbraco-library-quick-reference"

# Build the DOC_XML_FILE from the autoexported file
xsltproc --xinclude -o "$DOC_XML_FILE" build-extensions.xslt "$EXPORTED_FILE"

# Build the resulting file
xsltproc --xinclude -o public/index.html build-docset.xslt "$DOC_XML_FILE"

# Build the SQL to populate the docSet.dsidx SQLLite database
xsltproc --xinclude -o sql/docs.sql build-sql.xslt "$DOC_XML_FILE"

# Build the Dash DocSet feed XML file
xsltproc -o "dist/$FEED_FILENAME.xml" --stringparam filename "$ARCHIVE_NAME" build-feed.xslt "$DOC_XML_FILE"

# Backup the existing DocSet (if any)
if [[ -d "$BUNDLE" ]]; then
	rm -rf "$BUNDLE.bak"
	mv "$BUNDLE" "$BUNDLE.bak"
fi

# Create the Docset Folder
mkdir -p "$BUNDLE/Contents/Resources/Documents/"

# Copy the HTML Doc(s)
cp -R public/* "$BUNDLE/Contents/Resources/Documents"

# Copy the Info.plist file
cp "lib/Info.plist" "$BUNDLE/Contents"

# Create the SQLite file + Index
sqlite3 "$BUNDLE/Contents/Resources/docSet.dsidx" "CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"
sqlite3 "$BUNDLE/Contents/Resources/docSet.dsidx" "CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);"

# Populate the index
sqlite3 "$BUNDLE/Contents/Resources/docSet.dsidx" ".read sql/docs.sql"

# Create the archived Docset file
tar --exclude='.DS_Store' -cvzf "dist/$ARCHIVE_NAME.tgz" "$BUNDLE"

# Clean up
rm -rf "$BUNDLE.bak"

echo "Completed build - don't forget to upload the $ARCHIVE_NAME.tgz and feed (XML) files to greystate.dk as well as all the HTML files"
