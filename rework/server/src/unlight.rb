# Unlight
# Copyright(c)2019 CPA
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

$:.unshift File.dirname(__FILE__)
d = File.dirname(__FILE__).gsub!("src","")
ENV['INLINEDIR']="#{d}lib/ruby_inline"

require 'rubygems'
require 'sequel'
require 'logger'
require 'dalli'
Sequel::Model.require_valid_table = false

require 'db_config'
if File.exist?(File.dirname(__FILE__)+"/server_ip.rb")
  require 'server_ip'
end

# 定数
require 'constants/common_constants'
require 'constants/reward_constants'
require 'constants/cpu_data_constants'
require 'constants/constants'
require 'constants/locale_constants'

# ルール
require 'rule/context'
require 'rule/event/event'

require 'rule/event/entrant_event'
require 'rule/event/multi_duel_event'
require 'rule/event/chara_card_event'
require 'rule/event/deck_event'
require 'rule/event/action_card_event'
require 'rule/event/avatar_event'
require 'rule/event/reward_event'
require 'rule/event/ai_event'

require 'rule/deck'
require 'rule/event_deck'
require 'rule/reward'
require 'rule/entrant'
require 'rule/multi_duel'

# Model
require 'model/action_card.rb'
require 'model/card_inventory.rb'
require 'model/channel.rb'
require 'model/chara_card.rb'
require 'model/chara_card_requirement.rb'
require 'model/chara_card_slot_inventory.rb'
require 'model/chara_card_deck.rb'
require 'model/chara_card_story.rb'
require 'model/chara_record.rb'
require 'model/cpu_card_data.rb'
require 'model/cpu_room_data.rb'
require 'model/dialogue.rb'
require 'model/dialogue_weight.rb'
require 'model/equip_card.rb'
require 'model/event_card.rb'
require 'model/feat.rb'
require 'model/passive_skill.rb'
require 'model/passive_skill_inventory.rb'
require 'model/feat_inventory.rb'
require 'model/friend_link.rb'
require 'model/invite_log.rb'
require 'model/comeback_log.rb'
require 'model/item_inventory.rb'
require 'model/lot_log.rb'
require 'model/match.rb'
require 'model/match_log.rb'
require 'model/monster_treasure_inventory.rb'
require 'model/part_inventory.rb'
require 'model/payment_log.rb'
require 'model/player.rb'
require 'model/quest.rb'
require 'model/achievement.rb'
require 'model/achievement_inventory.rb'
require 'model/quest_clear_log.rb'
require 'model/quest_land.rb'
require 'model/quest_log.rb'
require 'model/quest_map.rb'
require 'model/rare_card_lot.rb'
require 'model/real_money_item.rb'
require 'model/shop.rb'
require 'model/treasure_data.rb'
require 'model/weapon_card.rb'
require 'model/avatar_item.rb'
require 'model/avatar_part.rb'
require 'model/avatar_quest_inventory.rb'
require 'model/charactor.rb'
require 'model/avatar.rb'
require 'model/total_ranking.rb'
require 'model/weekly_duel_ranking.rb'
require 'model/total_duel_ranking.rb'
require 'model/weekly_quest_ranking.rb'
require 'model/total_quest_ranking.rb'
require 'model/total_chara_vote_ranking.rb'
require 'model/total_event_ranking.rb'
require 'model/estimation_ranking.rb'
require 'model/avatar_notice.rb'
require 'model/avatar_apology.rb'
require 'model/reward_data.rb'
require 'model/event_serial.rb'
require 'model/clear_code.rb'
require 'model/infection_collabo_serial.rb'
require 'model/watch_duel.rb'
require 'model/watch_real_duel.rb'
require 'model/profound_data.rb'
require 'model/profound.rb'
require 'model/profound_inventory.rb'
require 'model/profound_log.rb'
require 'model/profound_comment.rb'
require 'model/profound_treasure_data.rb'
require 'model/scenario.rb'
require 'model/scenario_inventory.rb'
require 'model/scenario_flag_inventory.rb'
require 'model/event_quest_flag.rb'
require 'model/event_quest_flag_inventory.rb'
require 'model/combine_case.rb'
require 'model/reissue_request.rb'
require 'rule/ai'

require 'extension'

# メモリリークチェック用関数
module Unlight
  require "objspace"

  def self::puts_obj_count(c)
    count = ObjectSpace.each_object(c) { |x| x }
      SERVER_LOG.info( "LEAK_CHECK:#{c.name} num is #{count}")
  end

  def self::debug_memory_leak
    GC::Profiler.enable
    GC.start()
    GC::Profiler.report
    p Time.now
    puts "OBJ COUNT  #{ObjectSpace.count_objects}"
    # puts "OBJ COUNT_SIZE  #{ObjectSpace.count_objects_size}"
    # puts "OBJ MEM_SIZE #{ObjectSpace.memsize_of_all}"
    # puts "OBJ TDATA_COUNT  #{ObjectSpace.count_tdata_objects}"
    SERVER_LOG.info( "LEAK_CHECK:ModelObj")
    puts_obj_count(ActionCard)
    puts_obj_count(CardInventory)
    puts_obj_count(Channel)
    puts_obj_count(CharaCard)
    puts_obj_count(CharaCardSlotInventory)
    puts_obj_count(CharaCardDeck)
    puts_obj_count(EventCard)
    puts_obj_count(Feat)
    puts_obj_count(PassiveSkill)
    puts_obj_count(PassiveSkillInventory)
    puts_obj_count(FeatInventory)
    puts_obj_count(Player)
    puts_obj_count(Avatar)
    puts_obj_count(ProfoundData)
    puts_obj_count(Profound)
    puts_obj_count(ProfoundInventory)
    puts_obj_count(ProfoundLog)
    puts_obj_count(ProfoundComment)
    puts_obj_count(ProfoundTreasureData)
    SERVER_LOG.info( "LEAK_CHECK:EventObj")
    puts_obj_count(Deck)
    puts_obj_count(EventDeck)
    puts_obj_count(Reward)
    puts_obj_count(Entrant)
    puts_obj_count(MultiDuel)
    puts_obj_count(Array)
#     puts_obj_count(QuestServer)
#     puts_obj_count(ItemInventory)
#     puts_obj_count(LotLog)
#     puts_obj_count(Match)
#     puts_obj_count(MatchLog)
#     puts_obj_count(MonsterTreasureInventory)
#     puts_obj_count(PaymentLog)
  end


end

