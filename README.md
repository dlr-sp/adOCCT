# adOCCT: Algorithmic Differentiation of the Open CASCADE Technology modeling kernel

Algorithmic Differentiation (AD) is applied
to [Open CASCADE Technology (OCCT)](https://github.com/Open-Cascade-SAS/OCCT)
to compute geometric sensitivities (e.g., derivatives of
surface nodes with respect to its design parameters such as control points).
The resulting differentiated variant, named *adOCCT*, was initially achieved by integrating the AD software tool
[ADOL-C](https://github.com/coin-or/adol-c) (*Automatic Differentiation by Overloading in C++*)
into OCCT's source code.
Subsequently, adOCCT was extended to support AD using
[CoDiPack](https://github.com/SciCompKL/CoDiPack) (*Code Differentiation Package*).

## License

adOCCT is free software; you can redistribute it and/or modify it under the terms of the GNU
Lesser General Public License version 2.1 as published by the Free Software Foundation, with a special exception defined
in the file `OCCT_LGPL_EXCEPTION.txt`. Consult the file `LICENSE_LGPL_21.txt` included in the adOCCT distribution for
the complete text of the license.

**Note:** adOCCT is provided on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND. The entire risk related to any use of
the adOCCT code and materials is on you. See the license text for a formal disclaimer.

## Requirements and steps to build from sources

adOCCT is currently being tested only on Linux distributions.
To use it, adOCCT has to be built from sources to ensure compatibility with your platform (OS, compiler).
The process of configuring and building adOCCT using CMake is very similar to the original OCCT workflow.
Please consult the
official [Building OCCT](https://dev.opencascade.org/doc/occt-7.9.0/overview/html/build_upgrade__building_occt.html)
page for instructions.
Additional steps and requirements are described in the following.

### Choosing between supported AD software tools

One can choose between ADOL-C and CoDiPack to compute geometric sensitivities in adOCCT.
In any case, both forward and reverse mode of AD can be used.

#### ADOL-C

For the purpose of OCCT differentiation, the ADOL-C library *v2.7.2* is used under the terms of Eclipse Public License
1.0.
To download ADOL-C, please refer to its [official page](https://github.com/coin-or/adol-c).
Its version considered here is referenced by the tag *releases/2.7.2*.

When configuring ADOL-C, one has to activate the flag `--enable-atrig-erf`.
For example, its installation process can be executed as follows:

```
./configure --prefix=<ADOLC_PREFIX> --enable-atrig-erf
make && make install
```

where `<ADOLC_PREFIX>` is the desired destination where header- and library-files are going to be installed.

#### CoDiPack

As [stated](https://github.com/SciCompKL/CoDiPack/blob/c25d5c19d8207a1a732cfff0f79ac04cbeef01d8/EXEMPTIONS.md) in the official CoDiPack project repository on
GitHub (https://github.com/SciCompKL/CoDiPack), the copyright holders of CoDiPack have granted
a project-specific additional permission allowing the use of CoDiPack in adOCCT under the terms of
the GNU Lesser General Public License, version 2.1 (LGPL-2.1). For the applicable licensing terms and
the additional permission, please refer to the official CoDiPack repository.

To download CoDiPack, please refer to its [official page](https://github.com/SciCompKL/CoDiPack).
Its release *v3.1.3* (or later) is considered here.

Inside its source directory one can execute the following to install CoDiPack:

```
cmake -B build -DCMAKE_INSTALL_PREFIX=<CODIPACK_PREFIX>
cmake --install build
```

where `<CODIPACK_PREFIX>` is the desired destination where header- and configuration-files are going to be installed.

### adOCCT

The AD-branch is named `ad/master` and it is the default branch for this repository.

Examples of CMake commands can be found in a GitHub workflow of this project:
[`ad-build-and-test.yml`](.github/workflows/ad-build-and-test.yml).
The relevant configuration variables are explained as follows.

While configuring adOCCT using CMake, set either `USE_ADOLC=ON` or `USE_CODIPACK=ON` flag, depending on your
preferred AD tool.

**ADOL-C-related CMake variables**:

* `3RDPARTY_ADOLC_DIR`: Path to the ADOL-C installation directory (i.e., `<ADOLC_PREFIX>`).
* `ADOLC_REVERSE_MODE`: Boolean flag. If `ON`, adOCCT is built using ADOL-C’s *trace-based* headers enabling
  reverse-mode AD;
  otherwise, the *traceless adouble* header is used for forward-mode AD.
* `3RDPARTY_BOOST_DIR`: Optional path. If ADOL-C was built with Boost support, specify the Boost installation directory.
  This enables more efficient memory management of `adouble` objects in the *traceless* forward-mode AD.

**CoDiPack-related CMake variables**:

* `CoDiPack_DIR`: Path to the CoDiPack installation directory (i.e., `<CODIPACK_PREFIX>`).
* `CODIPACK_REVERSE_MODE`: Boolean flag. If `ON`, `codi::RealReverse` is used; otherwise, `codi::RealForward` is used
  as the AD type.

**Common CMake variables**:

* `BUILD_AD_TESTS`: Boolean flag. If `ON`, the AD tests in the [`tests-ad`](tests-ad) directory are built.
  These tests use `GoogleTest`, which is automatically downloaded and installed via CMake’s `FetchContent` module.
* `BUILD_CPP_STANDARD`: Specifies the desired C++ standard. It is recommended to use `C++17`, as required by
  CoDiPack and GoogleTest. When using ADOL-C, older standards like `C++11` or `C++14` are supported, but note that
  using them may require setting `BUILD_AD_TESTS=OFF` due to compatibility constraints.
* `INSTALL_DIR`: Path where adOCCT is going to be installed.

Once the configuration step is completed, one can execute the following commands to build and install adOCCT (replace
`<BUILD_DIR>` and `<NUMBER_OF_THREADS>` accordingly):

```
cmake --build <BUILD_DIR> -j<NUMBER_OF_THREADS>
cmake --install <BUILD_DIR>
```

Note: `-Wextra` has been removed from `CMAKE_CXX_FLAGS` in the file
[`adm/cmake/occt_defs_flags.cmake`](adm/cmake/occt_defs_flags.cmake)
to discard warnings regarding ADOL-C.

## Version

The current version of adOCCT can be found in the file [`adm/cmake/version.cmake`](adm/cmake/version.cmake).

## Cite as

- Banović, M., Mykhaskiv, O., Auriemma, S., Walther, A., Legrand, H., and Müller, J. D. (2018). Algorithmic
  differentiation of the Open CASCADE Technology CAD kernel and its coupling with an adjoint CFD solver.
  Optimization Methods and Software, 33 (4–6), 813–828. https://doi.org/10.1080/10556788.2018.1431235
- Hafemann, T., Banović, M. , Büchner, A. , Ehrmanntraut, S., Höing, C., Gottfried, S., and Stück, A. (2024).
  A CAD-enabled MDAO Framework Approach for Gradient-based Aerodynamic Shape Optimization.
  In: 9th European Congress on Computational Methods in Applied Sciences and Engineering (ECCOMAS 2024).
  https://doi.org/10.23967/eccomas.2024.199

## Note

The software is provided as is. We sincerely welcome your feedback on issues, bugs and
possible improvements. Please use the issue tracker of the project for the corresponding
communication or make a fork. Our priority and timeline for working on the issues depend
on the project and its follow-ups. This may lead to issue and tickets, which are not pursued.
In case you need an urgent fix, please contact us directly for discussing possible forms of
collaboration (direct contribution, projects, contracting, ...):
[Institute of Software Methods for Product Virtualization](https://www.dlr.de/sp)
