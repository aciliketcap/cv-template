I have a wee bit of a convoluted CV because of various role changes I have made in the past. Also it's probably [normal after certain years of experience](https://www.reddit.com/r/ProgrammerHumor/comments/12i7z6q/this_is_true/). I know other people who also have multiple CVs from which they choose depending on the role they're applying.

So I wanted to spend some effort and hold my CV in code form (CV-as-Code if you may) since copy+pasting and then editing files is a recipe to get lost in different versions of different documents. This is the template that worked for me so far.

### What you need to add to customize:
- Your details in `params.tex`
- Lots of experience in the form of `experience.tex`, might as well be spread across multiple files
- A `skill.json` file with all your skills tagged for different roles or topics
- A generic personal statement in `personal-statement.tex` (of course you can have multiple ones in different files too)

### The workflow I use is:
- Preferably checkout a new branch if you're not going to add new content or change the scripts or the tex template.
- Edit `personal-statement.tex` if necessary.
- Copy+paste only the relevant lines across your experience file(s) into `experience.tex` (this can also be automated if you really want to). And then edit/tweak it further if necessary.
- Commit with any relevant notes and leave the branch open (in case you need to tweak it further).
  - Branch name will be used as the project name if you upload the output to Overleaf.
- Run `build.ps1` and upload the `.zip` file to Overleaf as a new project. Create and download the PDF.
  - You can provide tags like `-Tags "DevOps","IT infra"`. They must match the tags in `skills.json`.
  - The CV will contain an invisible (white on white) line at the end which contains the latest commit hash. To be able to find it later you need to take care and push every time you build a CV in case you delete or edit the local commit.
- You may want to iterate a bit and when you're done, commit the final build which contains the latest-greatest commit hash to finalize

### TODO:
- Use Python for build instead of Powershell or bash
- Use Jinja to produce `skills.tex` instead of `jq`

### Feature Requests (which I don't strongly consider implementing):
- Initially I thought I'd group skills like "Soft Skills", "Tech", "Knowledge" etc. Or maybe make a bullet list but with relevant icons per skill. That's why there is a `"type"` field in `skills.json`
- Come up with a way to link skills to roles so that they can be listed under them
- Option to add some skills white-on-white, for the ATSs. Just like how people used to do in websites for SEO during 2000s.
