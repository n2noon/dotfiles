# TODO
- add neotest
- get task running/debugging
- get bookmarks set up
- use mini.ai for ciq?
- surround

dap: look at https://www.reddit.com/r/neovim/comments/1ho7n3v/what_do_you_miss_from_vscode_if_you_even_miss/m48olf9/
ideavim: https://gist.github.com/mikeslattery/d2f2562e5bbaa7ef036cf9f5a13deff5


# Learn
You can use \zs and \ze to mark the start and end of the capture, anything on the other side of these will be matched against but not captured.
For example, this will change words beginning with foo to foobar:
s/foo\zs\w\+/bar/
