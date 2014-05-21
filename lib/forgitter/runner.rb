require 'octokit'

module Forgitter
  class Runner
    def initialize(types = Forgitter::DEFAULT_TYPES, editors = Forgitter::DEFAULT_EDITORS, stdout = false)
      @types = convert_to_filenames(types)
      @editors = convert_to_filenames(text_editors)
      @stdout = stdout
    end

    def run
      output = ""
      @types.each do |type|
        output += "# Information from #{type}\n"
        output += get_ignore_file(type)
      end
      @editors.each do |editor|
        output += "# Information from #{editor}\n"
        output += get_ignore_file(editor)
      end

      if @stdout
        puts output
      else
        File.open('.gitignore', 'w') do |file|
          file.write(output)
        end
      end
    end

    private

    # Given a filename on the gitignore repo, return a string with the contents of the file
    def get_ignore_file(filename)
      puts "Getting #{filename}"
      api_response = Octokit.contents('github/gitignore', :ref => 'master', :path => filename)
      Base64.decode64( api_response.content )
    end

    # converts "rails" or "Rails" into "Rails.gitignore"
    def convert_to_filenames(names)
      names.map do |name|
        conversion_table[name.downcase.gsub(/[^+a-z]/i, '')]
      end.compact
    end

    # TODO make a constant
    def conversion_table
      {
        'actionscript' => 'Actionscript.gitignore',
        'ada' => 'Ada.gitignore',
        'agda' => 'Agda.gitignore',
        'android' => 'Android.gitignore',
        'appceleratortitanium' => 'AppceleratorTitanium.gitignore',
        'archlinuxpackages' => 'ArchLinuxPackages.gitignore',
        'autotools' => 'Autotools.gitignore',
        'bancha' => 'Bancha.gitignore',
        'c++' => 'C++.gitignore',
        'c' => 'C.gitignore',
        'cfwheels' => 'CFWheels.gitignore',
        'cmake' => 'CMake.gitignore',
        'cakephp' => 'CakePHP.gitignore',
        'chefcookbook' => 'ChefCookbook.gitignore',
        'clojure' => 'Clojure.gitignore',
        'codeigniter' => 'CodeIgniter.gitignore',
        'commonlisp' => 'CommonLisp.gitignore',
        'composer' => 'Composer.gitignore',
        'concrete' => 'Concrete5.gitignore',
        'coq' => 'Coq.gitignore',
        'dm' => 'DM.gitignore',
        'dart' => 'Dart.gitignore',
        'delphi' => 'Delphi.gitignore',
        'drupal' => 'Drupal.gitignore',
        'episerver' => 'EPiServer.gitignore',
        'eagle' => 'Eagle.gitignore',
        'elisp' => 'Elisp.gitignore',
        'elixir' => 'Elixir.gitignore',
        'erlang' => 'Erlang.gitignore',
        'expressionengine' => 'ExpressionEngine.gitignore',
        'fancy' => 'Fancy.gitignore',
        'finale' => 'Finale.gitignore',
        'forcedotcom' => 'ForceDotCom.gitignore',
        'fuelphp' => 'FuelPHP.gitignore',
        'gwt' => 'GWT.gitignore',
        'go' => 'Go.gitignore',
        'gradle' => 'Gradle.gitignore',
        'grails' => 'Grails.gitignore',
        'haskell' => 'Haskell.gitignore',
        'idris' => 'Idris.gitignore',
        'java' => 'Java.gitignore',
        'jboss' => 'Jboss.gitignore',
        'jekyll' => 'Jekyll.gitignore',
        'joomla' => 'Joomla.gitignore',
        'jython' => 'Jython.gitignore',
        'kohana' => 'Kohana.gitignore',
        'laravel' => 'Laravel4.gitignore',
        'leiningen' => 'Leiningen.gitignore',
        'lemonstand' => 'LemonStand.gitignore',
        'lilypond' => 'Lilypond.gitignore',
        'lithium' => 'Lithium.gitignore',
        'magento' => 'Magento.gitignore',
        'maven' => 'Maven.gitignore',
        'mercury' => 'Mercury.gitignore',
        'meteor' => 'Meteor.gitignore',
        'node' => 'Node.gitignore',
        'ocaml' => 'OCaml.gitignore',
        'objcetivec' => 'Objective-C.gitignore',
        'opa' => 'Opa.gitignore',
        'opencart' => 'OpenCart.gitignore',
        'oracleforms' => 'OracleForms.gitignore',
        'packer' => 'Packer.gitignore',
        'perl' => 'Perl.gitignore',
        'phalcon' => 'Phalcon.gitignore',
        'playframework' => 'PlayFramework.gitignore',
        'plone' => 'Plone.gitignore',
        'prestashtop' => 'Prestashop.gitignore',
        'processing' => 'Processing.gitignore',
        'python' => 'Python.gitignore',
        'qooxdoo' => 'Qooxdoo.gitignore',
        'qt' => 'Qt.gitignore',
        'r' => 'R.gitignore',
        'ros' => 'ROS.gitignore',
        'rails' => 'Rails.gitignore',
        'rhodesrhomobile' => 'RhodesRhomobile.gitignore',
        'ruby' => 'Ruby.gitignore',
        'scons' => 'SCons.gitignore',
        'sass' => 'Sass.gitignore',
        'scala' => 'Scala.gitignore',
        'scrivener' => 'Scrivener.gitignore',
        'sdcc' => 'Sdcc.gitignore',
        'seamgen' => 'SeamGen.gitignore',
        'sketchup' => 'SketchUp.gitignore',
        'sugarcrm' => 'SugarCRM.gitignore',
        'symfony' => 'Symfony.gitignore',
        'symfonytwo' => 'Symfony2.gitignore',
        'symphonycms' => 'SymphonyCMS.gitignore',
        'target' => 'Target3001.gitignore',
        'tasm' => 'Tasm.gitignore',
        'tex' => 'TeX.gitignore',
        'textpattern' => 'Textpattern.gitignore',
        'turbogears' => 'TurboGears2.gitignore',
        'typo' => 'Typo3.gitignore',
        'umbraco' => 'Umbraco.gitignore',
        'unity' => 'Unity.gitignore',
        'vvvv' => 'VVVV.gitignore',
        'visualstudio' => 'VisualStudio.gitignore',
        'waf' => 'Waf.gitignore',
        'wordpress' => 'WordPress.gitignore',
        'yeoman' => 'Yeoman.gitignore',
        'yii' => 'Yii.gitignore',
        'zendframework' => 'ZendFramework.gitignore',
        'gcov' => 'gcov.gitignore',
        'nanoc' => 'nanoc.gitignore',
        'stella' => 'stella.gitignore',

        'archives' => 'Global/Archives.gitignore',
        'bricxcc' => 'Global/BricxCC.gitignore',
        'cvs' => 'Global/CVS.gitignore',
        'cloud' => 'Global/Cloud9.gitignore',
        'darteditor' => 'Global/DartEditor.gitignore',
        'dreamweaver' => 'Global/Dreamweaver.gitignore',
        'eclipse' => 'Global/Eclipse.gitignore',
        'eiffelstudio' => 'Global/EiffelStudio.gitignore',
        'emacs' => 'Global/Emacs.gitignore',
        'ensime' => 'Global/Ensime.gitignore',
        'espresso' => 'Global/Espresso.gitignore',
        'flexbuilder' => 'Global/FlexBuilder.gitignore',
        'ipythonnotebook' => 'Global/IPythonNotebook.gitignore',
        'jetbrains' => 'Global/JetBrains.gitignore',
        'kdevelop' => 'Global/KDevelop4.gitignore',
        'kate' => 'Global/Kate.gitignore',
        'lazarus' => 'Global/Lazarus.gitignore',
        'linux' => 'Global/Linux.gitignore',
        'matlab' => 'Global/Matlab.gitignore',
        'mercurial' => 'Global/Mercurial.gitignore',
        'modelsim' => 'Global/ModelSim.gitignore',
        'monodevelop' => 'Global/MonoDevelop.gitignore',
        'netbeans' => 'Global/NetBeans.gitignore',
        'notepad' => 'Global/NotepadPP.gitignore',
        'notepadpp' => 'Global/NotepadPP.gitignore',
        'osx' => 'Global/OSX.gitignore',
        'quartus' => 'Global/Quartus2.gitignore',
        'redcar' => 'Global/Redcar.gitignore',
        'sbt' => 'Global/SBT.gitignore',
        'svn' => 'Global/SVN.gitignore',
        'slickedit' => 'Global/SlickEdit.gitignore',
        'sublimetext' => 'Global/SublimeText.gitignore',
        'tags' => 'Global/Tags.gitignore',
        'textmate' => 'Global/TextMate.gitignore',
        'vagrant' => 'Global/Vagrant.gitignore',
        'virtualenv' => 'Global/VirtualEnv.gitignore',
        'windows' => 'Global/Windows.gitignore',
        'xcode' => 'Global/Xcode.gitignore',
        'xilinxise' => 'Global/XilinxISE.gitignore',
        'vim' => 'Global/vim.gitignore',
        'webmethods' => 'Global/webMethods.gitignore'
      }
    end
  end
end
