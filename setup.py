from setuptools import setup, find_packages

setup(
    name='pyrenderdoc',
    version='0.1.0',
    license='proprietary',
    description='Pyrenderdoc',
    author='vnapdv',
    author_email='kaz380@hotmail.co.jp',
    url='None.com',
    packages=[str('pyrenderdoc'), str('pyrenderdoc/rdtest'), str('pyrenderdoc/parse')],
    python_requires='>=3',
)

