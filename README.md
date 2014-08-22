# ReleaseNotes

A Perl script to generate stylised HTML release notes from the Github API.

## Brief

Some sort of static page generator which sucks up github issues for a particular release (or regen for all releases),
formats it nicely, either using our skin, or just into a form that gets plugged into our /article/ dir and picked up from there.

Inspiration: https://www.mozilla.org/en-US/firefox/31.0/releasenotes/
API: https://api.github.com/repos/theCrag/website/issues?milestone=10&state=closed

## Requirements

- Needs to be aware of bugs vs enhancements vs new features. 
- New features get a bigger blurb, possibly extracted from the issue description
- Bugs just get a link to github issue, just show the name
- Generate a nice icon for each release for when we link to it from facebook etc
- Can exclude certain milestones
- Only works for milestones that are closed
- For new features, improvements: include the issues description up to a -- marker
- If tagged internal then ignore
- If run with no input arguments, runs through every milestone and generates a page for it. We'll need this for the back history anyway, may as well re-run it each release, sometimes the odd issue gets moved or reopened.
- Each milestone becomes it's own file based on the milestone name, eg "Release 39 - Topo rewrite" becomes "release-37.html" based on the pattern "Release (\d+) - (.*)". If it doesn't match this pattern throw a warning to stderr and ignore that milestone.
- Make an index page which lists all releases and their dates and links into each
- Ideally any images embedded in the markdown in the issue description should come through properly
- Link to this for testing: http://static.thecrag.com/cids/portal-1.1.29.css

## Progress

Basic Stages. Can pull the GitHub API but not parsing. Simple HTML formatting using portal.css.

