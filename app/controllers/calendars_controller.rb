# coding: utf-8
# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    @calendar = Calendar.find(params[:id])
  end
end
