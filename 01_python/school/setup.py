
from setuptools import setup, find_packages

setup(
    name = "dss", # name 이름으로 설치가 된다.
    packages=find_packages(),
    include_package_data=True,
    version="0.0.1",
    author="Sangjulee",
    author_email="lsj952005@gmail.com",
    zip_safe=False
)
