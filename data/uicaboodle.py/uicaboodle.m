#include <Python.h>
#include "pyobjc-api.h"
#import <UIKit/UIKit.h>

#define _trace() \
    fprintf(stderr, "_trace():%s(%d):%s\n", __FILE__, __LINE__, __FUNCTION__)

#define _assert(test) \
    do if (!(test)) { \
        fprintf(stderr, "_assert(%s):%s(%d):%s\n", #test, __FILE__, __LINE__, __FUNCTION__); \
        exit(-1); \
    } while (false)

static PyObject*  objc_UIApplicationMain(
    PyObject *self __attribute__((__unused__)),
    PyObject *args
) {
    int argc;
    char **argv;
    size_t i;
    int res = -1;

    PyObject *arga;
    PyObject *_class;

    _assert(PyObjC_API != NULL);
    _assert(args != NULL);

    if (!PyArg_ParseTuple(args, "OO", &arga, &_class)) {
	PyErr_SetString(PyExc_TypeError, "Invalid Arguments");
        return NULL;
    }

    _assert(arga != NULL);
    _assert(_class != NULL);

    argc = PySequence_Size(arga);
    argv = calloc(argc + 1, sizeof(char *));

    if (argv == NULL) {
	PyErr_SetString(PyExc_MemoryError, "Out of memory");
	return NULL;
    }

    for (i = 0; i != argc; ++i) {
        PyObject *arg = PySequence_GetItem(arga, i);
        if (arg == NULL) {
            PyErr_SetString(PyExc_TypeError, "UIApplicationMain: null argument");
            goto error;
        }

        if (!PyString_Check(arg)) {
            PyErr_SetString(PyExc_TypeError, "UIApplicationMain: non-string argument");
            goto error;
        }

        argv[i] = strdup(PyString_AsString(arg));
        if (argv[i] == NULL) {
            PyErr_SetString(PyExc_MemoryError, "Out of memory");
            goto error;
        }
    }

    PyObjC_DURING
        res = UIApplicationMain(argc, argv, PyObjC_API->cls_get_class(_class));
    PyObjC_HANDLER
        PyObjCErr_FromObjC(localException);
    PyObjC_ENDHANDLER

  error:
    for (i = 0; i != argc; ++i)
        free(argv[i]);
    free(argv);

    if (res == -1 && PyErr_Occurred())
        return NULL;
    return PyInt_FromLong(res);
}

static PyMethodDef mod_methods[] = {{
    "UIApplicationMain",
    /*(PyCFunction)*/ objc_UIApplicationMain,
    METH_VARARGS|METH_KEYWORDS,
    "int UIApplicationMain(int argc, const char *argv[], Class _class);"
}, {
    NULL, NULL, 0, NULL
}};

void init_uicaboodle(void) {
    PyObject *module = Py_InitModule4("_uicaboodle", mod_methods, "", NULL, PYTHON_API_VERSION);
    PyObjC_ImportAPI(module);
}
