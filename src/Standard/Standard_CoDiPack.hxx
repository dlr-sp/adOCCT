// Created on: 2026-10-29
// Created by: Mladen Banovic
// Copyright (c) German Aerospace Center (DLR e.V.)
//
// This file is part of Open CASCADE Technology software library.
//
// This library is free software; you can redistribute it and/or modify it under
// the terms of the GNU Lesser General Public License version 2.1 as published
// by the Free Software Foundation, with special exception defined in the file
// OCCT_LGPL_EXCEPTION.txt. Consult the file LICENSE_LGPL_21.txt included in OCCT
// distribution for complete text of the license and disclaimer of any warranty.

#ifndef _Standard_CoDiPack_HeaderFile
#define _Standard_CoDiPack_HeaderFile

#ifdef HAVE_CODIPACK

  // As stated in the official CoDiPack project repository on
  // GitHub (https://github.com/SciCompKL/CoDiPack), the copyright holders of CoDiPack have granted
  // a project-specific additional permission allowing the use of CoDiPack in adOCCT under the terms
  // of the GNU Lesser General Public License, version 2.1 (LGPL-2.1). For the applicable licensing
  // terms and the additional permission, please refer to the official CoDiPack repository.
  #include <codi.hpp>

  #ifdef CODIPACK_REVERSE_MODE
namespace std
{

template <>
struct hash<codi::RealReverse>
{
  size_t operator()(const codi::RealReverse& a) const noexcept
  {
    return hash<double>()(a.getValue());
  }
};

// std::numeric_limits
template <>
struct numeric_limits<codi::RealReverse>
{
  static codi::RealReverse min() { return codi::RealReverse(std::numeric_limits<double>::min()); };

  static codi::RealReverse max() { return codi::RealReverse(std::numeric_limits<double>::max()); };

  static codi::RealReverse epsilon()
  {
    return codi::RealReverse(std::numeric_limits<double>::epsilon());
  };

  static constexpr bool is_specialized{true};
};

} // namespace std
  #else
namespace std
{

template <>
struct hash<codi::RealForward>
{
  size_t operator()(const codi::RealForward& a) const noexcept
  {
    return hash<double>()(a.getValue());
  }
};

// std::numeric_limits
template <>
struct numeric_limits<codi::RealForward>
{
  static codi::RealForward min() { return codi::RealForward(std::numeric_limits<double>::min()); };

  static codi::RealForward max() { return codi::RealForward(std::numeric_limits<double>::max()); };

  static codi::RealForward epsilon()
  {
    return codi::RealForward(std::numeric_limits<double>::epsilon());
  };

  static constexpr bool is_specialized{true};
};

} // namespace std
  #endif

#endif

#endif