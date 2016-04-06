require 'formula'

class I386JosElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'ftp://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.gz'
  sha256 '9615feddaeedc214d1a1ecd77b6697449c952eab69d79ab2125ea050e944bcc1'

  #depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-5'
    ENV['CXX'] = '/usr/local/bin/g++-5'
    ENV['CPP'] = '/usr/local/bin/cpp-5'
    ENV['LD'] = '/usr/local/bin/gcc-5'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-jos-elf',
                             '--disable-werror',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
