%module sbigpy

%include "carrays.i"
%include "cdata.i"

%array_class(char, charArray);

%{
#include "sbigudrv.h"
%}

%define OBJ2LIST(type)
%typemap(out) type [ANY] {
  int i;

  $result = PyList_New($1_dim0);

  for (i = 0; i < $1_dim0; i++) {
    PyObject *obj = SWIG_NewPointerObj(&$1[i], SWIGTYPE_p_ ## type, 0);
    PyList_SetItem($result,i,obj);
  }
 }
%enddef

OBJ2LIST(QUERY_USB_INFO);
OBJ2LIST(READOUT_INFO);

%include "sbigudrv.h"

%inline %{
  void readoutLine(ReadoutLineParams* rlp, char* dest, int offset) {
    SBIGUnivDrvCommand(CC_READOUT_LINE, rlp, (((void*) dest)+offset));
    //printf("Offset=%d; Ptr=%p; Dest=%p\n", offset, dest, dest+offset);
  }
  %}
