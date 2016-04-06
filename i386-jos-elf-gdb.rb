require 'formula'

class I386JosElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'ftp://ftp.gnu.org/gnu/gdb/gdb-7.9.1.tar.gz'
  sha256 '4994ad986726ac4128a6f1bd8020cd672e9a92aa76b80736563ef992992764ef'

  depends_on 'i386-jos-elf-binutils'
  depends_on 'i386-jos-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i386-jos-elf', "--prefix=#{prefix}", '--disable-werror'
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
      FileUtils.mv lib, libexec
    end
  end
end
