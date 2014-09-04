from distutils.core import setup, Extension

ENV_LINUX = 7

setup(name='sbigpy',
      version='0.1',
      description='Python SBIG universal driver binding',
      author='Tassilo Schweyer',
      author_email='dev@welterde.de',
      ext_modules=[Extension('_sbigpy', ['sbigpy.i'],
                             swig_opts=['-modern', '-Iinclude', "-DTARGET=%d" % ENV_LINUX],
                             include_dirs=['include'],
                             libraries=['sbigudrv'],
                             define_macros=[('TARGET', ENV_LINUX)])],
      py_modules=['sbigpy'],
      )
