# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_language(locale, label)
    html_options = { :class => ["lang_#{locale} "]}
    html_options[:class] << 'active ' if locale_active? locale
    
    link_to label, { :locale => locale }, html_options
  end
  
  def locale_active?(locale)
    I18n.locale == locale
  end
  
  def title(title)
    @title = t(title, :default => "").presence || h(title)
  end
end
