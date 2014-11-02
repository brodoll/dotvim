****************
Vim Config Files
****************

My Vim setup. It consists essentially of pieces of code I stumbled upon the web and managed to put together. It aims to provide an integrated python development ambient and LaTeX editing super fast. 

**Table of Contents**


.. contents::
    :local:
    :depth: 1
    :backlinks: none

============
Installation
============

-------
Windows
-------

1. Download VIM from'vimd'_.

2. Download GIT (allow call from cmd) from: 'gitd'_.

3. Copy curl to: 
	C:\Program Files\Git\cmd\

4. Copy repository:
	git clone git://github.com/brodroll/dotvim.git %userprofile%\vimfiles

5. Create symlinks:
	mklink %userprofile%\_vimrc %userprofile%\vimfiles\_vimrc

6. Install vundle:
	git clone https://github.com/gmarik/Vundle.vim.git %userprofile%/vimfiles/bundle/Vundle.vim

7. Update plugins:
	:PluginInstall
	:PluginUpdate

-----
Linux
-----

1. Download GIT:
.. code-block:bash
	$ apt-get install git

2. Clone vimfiles repository:
	git clone git://github.com/brodroll/dotvim.git ~/vimfiles

3. Create symlinks:
.. code-block:bash
	ln -s ~/vimfiles/vimrc ~/.vimrc
	ln -s ~/vimfiles/gvimrc ~/.gvimrc

4. Install Vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/vimfiles/bundle/Vundle.vim

5. Updalte plugins:
	:PluginInstall
	:PluginUpdate

.. _vimd: http://www.vim.org/download.php
.. _gitd: http://git-scm.com/downloads
