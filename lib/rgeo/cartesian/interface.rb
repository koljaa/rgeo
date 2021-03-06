# -----------------------------------------------------------------------------
# 
# Cartesian toplevel interface
# 
# -----------------------------------------------------------------------------
# Copyright 2010 Daniel Azuma
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of the copyright holder, nor the names of any other
#   contributors to this software, may be used to endorse or promote products
#   derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# -----------------------------------------------------------------------------
;


module RGeo
  
  module Cartesian
    
    class << self
      
      
      # Creates and returns a cartesian factory of the preferred
      # Cartesian implementation.
      # 
      # The actual implementation returned depends on which ruby
      # interpreter is running and what libraries are available.
      # RGeo will try to provide a fully-functional and performant
      # implementation if possible. If not, the simple Cartesian
      # implementation will be returned.
      # 
      # The given options are passed to the factory's constructor.
      # What options are available depends on the particular
      # implementation. Unsupported options are ignored.
      
      def preferred_factory(opts_={})
        if ::RGeo::Geos.supported?
          ::RGeo::Geos.factory(opts_)
        else
          simple_factory(opts_)
        end
      end
      alias_method :factory, :preferred_factory
      
      
      # Returns a factory for the simple Cartesian implementation. This
      # implementation provides all SFS 1.1 types, and also allows Z and
      # M coordinates. It does not depend on external libraries, and is
      # thus always available, but it does not implement many of the more
      # advanced geometric operations. These limitations are:
      # 
      # * Relational operators such as Feature::Geometry#intersects? are
      #   not implemented for most types.
      # * Relational constructors such as Feature::Geometry#union are
      #   not implemented for most types.
      # * Buffer and convex hull calculations are not implemented for most
      #   types. Boundaries are available except for GeometryCollection.
      # * Length calculations are available, but areas are not. Distances
      #   are available only between points.
      # * Equality and simplicity evaluation are implemented for some but
      #   not all types.
      # * Assertions for polygons and multipolygons are not implemented.
      # 
      # Unimplemented operations will return nil if invoked.
      # 
      # Options include:
      # 
      # <tt>:srid</tt>::
      #   Set the SRID returned by geometries created by this factory.
      #   Default is 0.
      # <tt>:has_z_coordinate</tt>::
      #   Support a Z coordinate. Default is false.
      # <tt>:has_m_coordinate</tt>::
      #   Support an M coordinate. Default is false.
      
      def simple_factory(opts_={})
        Cartesian::Factory.new(opts_)
      end
      
      
    end
    
  end
  
end
