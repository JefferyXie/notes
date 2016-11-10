set breakpoint pending on
set print thread-events off
set auto-load safe-path /
set history save on
set history filename ~/.gdb_history

# Cause gdb to print structures in an indented format with one member per line
set print pretty on 
# When displaying a pointer to an object, identify the actual (derived) type of the object rather than the declared type, using the virtual function table
set print object on
# Print static members when displaying a C++ object. The default is on
set print static-members on
# Pretty print C++ virtual function tables. The default is off
set print vtbl on
# Print C++ names in their source form rather than in the encoded ("mangled") form passed to the assembler and linker for type-safe linkage. Default is on
set print demangle on
set demangle-style gnu-v3
# Print full eight-bit characters. This allows the use of more international character sets, and is the default
set print sevenbit-strings off


##########################################
############# custom commands ############
# to view user defined commands:
# > help user-defined
##########################################

# increase command window's height
define uu
    winheight CMD +10
end
# decrease command window's height
define dd
    winheight CMD -10
end

document uu
    Increase command window's height.
    Syntax: uu
end
document dd
    Decrease command window's height.
    Syntax: dd
end

# print pointer and content
# https://sourceware.org/gdb/onlinedocs/gdb/Define.html
define pp
    print $arg0
    print *($arg0)
end
document pp
    Print pointer and content.
    Syntax: pp pvariable
    Example:
    int* pv = new int(10);
    pp pv
end

# print smart pointer and content
define ps
    print $arg0
    pp $arg0._M_ptr
end
document ps
    Print smart pointer and content.
    Syntax: ps pvariable
    Example:
    shared_ptr<int> sp(new int(10));
    ps sp
end

#
# void * arr[]  -- via parray command   
# > parray arr "this command for print content infomantion of point array
# 
# pointer array
#

define parray
    if $argc < 1
        help parray
    else
        if $argc == 1
            set $i = 0
            set $current = *($arg0 + $i)
            while $current != 0 
                printf "[array element number: %u] \n", $i
                p *$current
                set $i++
                set $current = *($arg0 + $i)
            end
            printf "array size = %u\n", $i
        end

        if $argc == 2
            printf "arg1 is %u\n", $arg1
            printf "[array element number: %u] \n", $arg1 
            p *(*($arg0 + $arg1))
        end

        if $argc == 3
            set $i = $arg1
            printf " idx1 = %u, idx2 = %u \n" , $i, $arg2
            while $i < $arg2  
                printf "[array element number: %u] \n", $i
                p *(*($arg0 + $i))
                set $i++
            end
            printf "array size = %u\n", $i
        end
    end
end

document parray
    Print array infomation.
    Syntax: parray [elemnum | [idx1, idx2]]
    Example:
    parray array  
    parray array elenum 
    parray array idx1 idx2 
end


# GDB Pretty Printers for Boost
# https://github.com/ruediger/Boost-Pretty-Printer
#
#python
#import sys
#sys.path.insert(0, '/home/jexie/.vim/bundle/Boost-Pretty-Printer')
#sys.path.insert(0, '/home/jexie/.vim/bundle/Boost-Pretty-Printer')
#from boost.printers import register_printer_gen
#register_printer_gen(None)
#end

# GDB Pretty Printers for STD
# http://inlinechan.github.io/c++/2016/01/26/stl-gdb-prettyprinter.html
# 
#python
#import sys
#sys.path.insert(0, '/home/jeffery/.vim/bundle/STD-Pretty-Printer')
#sys.path.insert(0, '/home/jeffery/.vim/bundle/STD-Pretty-Printer/libstdcxx.v6')
#from libstdcxx.v6.printers import register_libstdcxx_printers
#register_libstdcxx_printers (None)
#end

# Or we can use following tips
# 
# http://blog.chinaunix.net/uid-25595605-id-3483217.html
#
# C++ related beautifiers (optional)
#

