require File.dirname(__FILE__) + '/../../spec_helper'

describe Sprinkle::Installers::PushText do

  before do
    @package = mock(Sprinkle::Package, :name => 'package')
  end

  def create_text(text, path, &block)
    Sprinkle::Installers::PushText.new(@package, text, path, &block)
  end

  describe 'when created' do

    it 'should accept a single package to install' do
      @installer = create_text 'crazy-configuration-methods', '/etc/doomed/file.conf'
      @installer.text.should == 'crazy-configuration-methods'
      @installer.path.should == '/etc/doomed/file.conf'
    end

  end

  describe 'during installation' do

    before do
      @installer = create_text 'another-hair-brained-idea', '/dev/mind/late-night' do
        pre :install, 'op1'
        post :install, 'op2'
      end
      @install_commands = @installer.send :install_commands
    end

    it 'should invoke the port installer for all specified packages' do
      @install_commands.should =~ /echo 'another-hair-brained-idea' | tee -a \/dev\/mind\/late-night/
    end

    it 'should automatically insert pre/post commands for the specified package' do
      @installer.send(:install_sequence).should == [ 'op1', "echo 'another-hair-brained-idea' | tee -a /dev/mind/late-night", 'op2' ]
    end

  end

end
