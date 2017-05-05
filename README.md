# WebtekFinals

Setting up Foundation CSS framework
	-through cli 
		-more customizable than the default package

Application needed
nodeJS - serves as a build file for foundation
Ruby - SASS compiler

how to install through cli
https://github.com/zurb/foundation-cli
open git bash and enter this commands
npm install -g gulp bower;
npm install -g foundation-cli //adds foundation commands on your system

foundation -v //to check if foundation is successfully installed

Creating Template for Website
go to the directory where you want to save the website (example desktop)
on git bash, go to the directory and enter
foundation new //creates the template and will prompt you what settings will be needed for the website
	//website
	//enter project name
	//basic template

then done

to assemble the template
change the directory to the newly created template
enter

foundation watch

//output
> foundation-sites-template@1.0.0 start C:\Users\User\Documents\GitHub\BxB
> gulp

[23:09:42] Using gulpfile ~\Documents\GitHub\BxB\gulpfile.js
[23:09:42] Starting 'sass'...
[23:09:50] Finished 'sass' after 7.93 s
[23:09:50] Starting 'default'...
[23:09:50] Finished 'default' after
//if the output looks like this it means that the build is successfull and you can now update files in the webpage

notes 
	-saving scss file while foundation watch will save a css
	-an error will show on git if you made an error in your scss file

if my instructions are not clear
refer to this site
https://github.com/zurb/foundation-cli

i tried lol
