#!/usr/bin/python
# -*- coding: utf-8 -*-

__author__="hara"
__date__ ="$2011/03/23 9:52:16$"

print "Content-Type: text/html"
print

import cgitb
cgitb.enable()

import cgi
import os
import shutil
import time

form = cgi.FieldStorage()

location = "/Volumes/"
#ボリュームのマウントポイントを指定。MacOSXは多分Volumes。

webdoc = "/Library/WebServer/Documents/temp/"
#Webサーバのドキュメントルート以下で一時ファイルの置き場所
#permitionを777にしておく


if form.has_key("selected"):
	location = location + form['selected'].value

if os.path.isdir(location):
    #ファイル一覧を表示
    
	print location + ':'
	list = os.listdir(location)
	for file in list:

		if os.path.isdir(location+file):
            #ディレクトリには「directory|」ラベルを付ける
			print "directory|";

		print file
		print ":"
else:
    #ボリューム上の実ファイルをWebサーバの/tempにコピーして、そのURLを出力
    #その際ファイル名をユニークな数字に変換し、もとの拡張子をつける。
    
	extention = location.split('.')
	for extItem in extention:
		extname = extItem
	copypath = webdoc + "%s" % time.clock()
	copypath = copypath + '.' + extname

 	shutil.copyfile(location, copypath)
	pathList = copypath.split('/')
	for pathItem in pathList:
		filename = pathItem
	
	print "http://192.168.100.209/temp/" + filename
    #WebサーバのIPアドレス。



