class WeaponUsagesController < ApplicationController
  def index
    weapons = Player.find(params[:player_id]).weapon_usages.joins(:weapon).select(select_sql)
      .where('weapon_usages.time_used >= 120').order('kpm desc')
    render json: { weapons: WeaponUsageSerializer.serialize_list(weapons) }
  end

  private

  def select_sql
    <<-SQL
      weapon_usages.*, weapons.name, weapons.image_url, weapons.weapon_type,
      (weapon_usages.kills::float / weapon_usages.time_used * 60) as kpm
    SQL
  end
end
