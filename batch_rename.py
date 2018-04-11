import os
import sys
#import file


print sys.argv[0]
print sys.argv[1]

files = os.listdir(sys.argv[1])  


for filename in files:  
    li = os.path.splitext(filename)  
    if li[1] == '.cc':  
        newname = li[0] + '.cpp'  
        os.rename(filename,newname)  

#def __main()__
    
    #f = os.open(sys.argv[0], "r")
    #for line in f:
     #   print line

    
    # rename(line,  dst, *, src_dir_fd=None, dst_dir_fd=None)
