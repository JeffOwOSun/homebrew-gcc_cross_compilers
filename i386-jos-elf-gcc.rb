require 'formula'

class I386JosElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2'
  sha256 'b84f5592e9218b73dbae612b5253035a7b34a9a1f7688d2e1bfaaf7267d5c4db'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-jos-elf-binutils'

  def install
    binutils = Formula.factory 'i386-jos-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-5'
    ENV['CXX'] = '/usr/local/bin/g++-5'
    ENV['CPP'] = '/usr/local/bin/cpp-5'
    ENV['LD'] = '/usr/local/bin/gcc-5'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-jos-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-jos-elf", prefix/"i386-jos-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
