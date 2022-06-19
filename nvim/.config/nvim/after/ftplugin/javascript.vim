" https://gist.github.com/romainl/2f748f0c0079769e9532924b117f9252

setlocal makeprg=npm\ run\ --silent\ lint:compact

setlocal formatprg=npm\ run\ --silent\ format\ --\ --stdin-filepath\ %

