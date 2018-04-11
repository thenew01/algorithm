#! /usr/bin/env python
#coding=utf-8

import sys,os

def main():	
    if len(sys.argv) != 4:
        print('copy src files to dest path')
        print('Usage:ycopy srcPath fileFormat destPath')
        print('e.g. ycopy d:\music *.mp3 d:\mp3')
        os.system("pause")
        return

    paths = "dir /B /S "
    paths += str(sys.argv[1])
    paths += str("\\")
    paths += str(sys.argv[2])
    paths += " > dir.txt"
    print(paths)

    os.system(paths)


    f = open("dir.txt")
    for line in f:
        cmd = "xcopy /Y  \""
        cmd += line.strip()
        cmd += "\" \"";
        cmd += sys.argv[3]
        cmd += "\"";
        print (cmd)        
        os.system(cmd)
    
    f.close()
    
    print('done.')
    os.system("pause")
		
if __name__ == '__main__':
	main()
