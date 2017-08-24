module Admin::EnumI18nHelper
  def sex_i18n(sex)
    I18n.t("activerecord.attributes.product.sex.#{sex}")
  end
end