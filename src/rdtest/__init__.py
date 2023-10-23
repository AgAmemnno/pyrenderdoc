import sys
import os
#WINDOWS Installer "https://www.python.org/ftp/python/3.6.8/python-3.6.8rc1-amd64.exe"
from .config import PYD_PATH
DLL_PATH = PYD_PATH 

os.environ["PATH"] += os.pathsep + os.path.abspath(DLL_PATH)
sys.path.append(PYD_PATH)

if 'renderdoc' not in sys.modules and '_renderdoc' not in sys.modules:
	import renderdoc
 
# Alias renderdoc for legibility
rd = renderdoc
if 'pyrenderdoc' in globals():
	raise RuntimeError("This sample should not be run within the RenderDoc UI")

#print(">>>>>>>>>>>>>>>>>>>RENDERDOC Loading Successfully")
#print(rd.CullMode.FrontAndBack)

from .util import *
from .capture import *
from .runner import *
from .analyse import *
from .testcase import *
from .task import *
