
namespace :update do

  maker = Proc.new do |t|
    require fn = t.prerequisites.first
    Update::Table.method(File.basename(fn,'.rb')).call(t.name)
  end

  docomo_files = {
    'lib/e4u/encode/docomo/cp932/docomo_unicode.rb'   => 'tasks/mk_docomo_cp932.rb',
    'lib/e4u/encode/docomo/unicode/google_unicode.rb' => 'tasks/mk_docomo_unicode.rb',
    'lib/e4u/encode/docomo/utf8/docomo_unicode.rb'    => 'tasks/mk_docomo_utf8.rb'
  }

  desc "update docomo datas"
  task :docomo => docomo_files.keys

  namespace :docomo do
    docomo_files.each do |target, prereq|
      file target => prereq, &maker
    end
  end

  google_files = {
    'lib/e4u/encode/google/unicode/docomo_unicode.rb'   => 'tasks/mk_google_unicode_docomo.rb',
    'lib/e4u/encode/google/unicode/kddi_unicode.rb'     => 'tasks/mk_google_unicode_kddi.rb',
    'lib/e4u/encode/google/unicode/softbank_unicode.rb' => 'tasks/mk_google_unicode_softbank.rb',
    'lib/e4u/encode/google/utf8/unicode.rb'             => 'tasks/mk_google_utf8.rb'
  }

  desc "update google datas"
  task :google => google_files.keys

  namespace :google do
    google_files.each do |target, prereq|
      file target => prereq, &maker
    end
  end

  kddi_files = {
    'lib/e4u/encode/kddi/cp932/kddi_unicode.rb'     => 'tasks/mk_kddi_cp932.rb',
    'lib/e4u/encode/kddi/unicode/google_unicode.rb' => 'tasks/mk_kddi_unicode.rb',
    'lib/e4u/encode/kddi/utf8/kddi_unicode.rb'      => 'tasks/mk_kddi_utf8.rb'
  }

  desc "update kddi datas"
  task :kddi => kddi_files.keys

  namespace :kddi do
    kddi_files.each do |target, prereq|
      file target => prereq, &maker
    end
  end

  softbank_files = {
    'lib/e4u/encode/softbank/cp932/softbank_unicode.rb' => 'tasks/mk_softbank_cp932.rb',
    'lib/e4u/encode/softbank/unicode/google_unicode.rb' => 'tasks/mk_softbank_unicode.rb',
    'lib/e4u/encode/softbank/utf8/softbank_unicode.rb'  => 'tasks/mk_softbank_utf8.rb'
  }

  desc "update softbank datas"
  task :softbank => softbank_files.keys

  namespace :softbank do
    softbank_files.each do |target, prereq|
      file target => prereq, &maker
    end
  end

end
