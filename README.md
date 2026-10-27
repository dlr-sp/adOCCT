# adOCCT: Algorithmic Differentiation of the Open CASCADE Technology modeling kernel

Algorithmic Differentiation (AD) is applied
to [Open CASCADE Technology (OCCT)](https://github.com/Open-Cascade-SAS/OCCT)
in order to enable the computation of the so-called geometric sensitivities (e.g., derivatives of
surface nodes with respect to its design parameters such as control points).
The differentiated OCCT variant, named *adOCCT*, is developed by integrating the AD tool
[ADOL-C](https://github.com/coin-or/adol-c) (*Automatic Differentiation by Overloading in C++*)
into its source-code.

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

### ADOL-C

For the purpose of OCCT differentiation, the ADOL-C library *v2.7.2* is used under the terms of Eclipse Public License
1.0.
To download ADOL-C, please refer to its [official page](https://github.com/coin-or/adol-c).
Its version considered here is referenced by the tag *releases/2.7.2*.

When configuring ADOL-C, one has to activate the flag `--enable-atrig-erf`.
For example, its installation process can be executed as follows:

```
./configure --prefix=ADOLC_PREFIX --enable-atrig-erf
make && make install
```

where `ADOLC_PREFIX` is the desired destination where header- and library-files are going to be installed.

### adOCCT

The steps to configure and build adOCCT are described as follows:

1. Checkout `ad/master` branch (should be done by default).
2. Configure adOCCT using CMake by setting the following variable: `USE_ADOLC=ON`.
   After that, a PkgConfig module for CMake is loaded to search for the existing ADOL-C installation.
   If it fails to find it, which can be the case with a local ADOL-C installation that is not added
   to common search paths, one has to manually set a variable `3RDPARTY_ADOLC_DIR` to the path where
   ADOL-C installation resides (i.e., `ADOLC_PREFIX` described previously).
   From that, variables for the ADOL-C include and library directories are automatically derived.
3. To activate the reverse mode of AD, set the variable `ADOLC_REVERSE_MODE=ON`. This will build adOCCT using the
   *trace-based* headers of ADOL-C, otherwise the *traceless* header of ADOL-C is employed which allows only
   the forward mode of AD.
4. Optionally, if ADOL-C has been built with Boost, one can provide the used Boost installation directory
   using the variable `3RDPARTY_BOOST_DIR`. This option makes the *traceless* feature of ADOL-C more performant
   as Boost is used to handle the memory management of *adouble* objects.
5. Optionally, one can build AD-tests by setting `BUILD_AD_TESTS=ON`.
6. Once the configuring is done, proceed with `make && make install`.

Note: `-Wextra` has been removed from `CMAKE_CXX_FLAGS` in the file [
`adm/cmake/occt_defs_flags.cmake`](adm/cmake/occt_defs_flags.cmake)
to discard warnings regarding ADOL-C.

## Version

The current version of adOCCT can be found in the file [`adm/cmake/version.cmake`](adm/cmake/version.cmake).

## Cite as

- Banović, M., Mykhaskiv, O., Auriemma, S., Walther, A., Legrand, H., and Müller, J. D. (2018). Algorithmic
  differentiation
of the Open CASCADE Technology CAD kernel and its coupling with an adjoint CFD solver. Optimization Methods and
Software, 33(4–6), 813–828. https://doi.org/10.1080/10556788.2018.1431235
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

## CoDiPack

As [stated](https://github.com/SciCompKL/CoDiPack/blob/c25d5c19d8207a1a732cfff0f79ac04cbeef01d8/EXEMPTIONS.md) in the official CoDiPack project repository on
GitHub (https://github.com/SciCompKL/CoDiPack), the copyright holders of CoDiPack have granted
a project-specific additional permission allowing the use of CoDiPack in adOCCT under the terms of
the GNU Lesser General Public License, version 2.1 (LGPL-2.1). For the applicable licensing terms and
the additional permission, please refer to the official CoDiPack repository.
