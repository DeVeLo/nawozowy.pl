# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'wojewodztwo', 'wojewodztwa'
  inflect.irregular 'gmina', 'gminy'
  inflect.irregular 'grunt', 'grunty'
  inflect.irregular 'plynny', 'plynne'
  inflect.irregular 'staly', 'stale'
  inflect.irregular 'gatunek', 'gatunki'
  inflect.irregular 'zwierze', 'zwierzeta'
  inflect.irregular 'pora', 'pory'
  inflect.irregular 'nazwautrzymania', 'nazwyutrzymania'
  inflect.irregular 'systemutrzymania', 'systemyutrzymania'
  inflect.irregular 'jednostkautrzymania', 'jednostkiutrzymania'
  inflect.irregular 'rodzajuprawy', 'rodzajeupraw'
  inflect.irregular 'roslina', 'rosliny'
  inflect.irregular 'kategoria', 'kategorie'
  inflect.irregular 'rownowaznik', 'rownowazniki'
  inflect.irregular 'wartoscrownowaznika', 'wartoscirownowaznikow'
  inflect.irregular 'sezon', 'sezony'
end
