# Umbraco Library Quick Reference

This is a quick reference/cheatsheet for the extension methods in the
`umbraco.library` namespace.

There's two main purposes for this:

1. For use with [Dash][DASH] on OS X - it's the perfect app for all sorts of API/reference lookups
2. To serve as a [reference section][UMBREF] on a website so you can easily point people to a URL that explains a specific method.

Feel free to use the [issue tracker][ISSUES] or perhaps even fork the repo and submit pull requests for discussion, if you see anything that's missing.

The actual docs are generated from the XML *doc comments* throughout the actual source code of the library, so any errors, typos etc. should be fixed by adding pull requests to that project.

## Credits

* Thanks to [@leekelleher][LEE] for supplying the exported XML docs from .NET

## Dev notes

I use [CodeKit][] for preprocessing the LESS file (enabling autoprefixer), and a simple bash script to transform the XML file with the list of methods into a single HTML file. Yay, XSLT!



*Chriztian Steinmeier, 2014*

[DASH]: http://kapeli.com/dash/
[UMBREF]: http://greystate.dk/resources/umbraco/reference/
[CodeKit]: http://incident57.com/codekit/
[ISSUES]: https://github.com/greystate/umb-reference/issues
[LEE]: https://github/leekelleher/