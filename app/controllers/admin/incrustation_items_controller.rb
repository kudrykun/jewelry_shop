class Admin::IncrustationItemsController < Admin::AdminController
  def new
    @incrustation_item = IncrustationItem.new
    @incrustations = Incrustation.all.order(:title)
  end
end