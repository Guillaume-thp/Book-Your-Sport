require "application_system_test_case"

class TimeslotsTest < ApplicationSystemTestCase
  setup do
    @timeslot = timeslots(:one)
  end

  test "visiting the index" do
    visit timeslots_url
    assert_selector "h1", text: "Timeslots"
  end

  test "creating a Timeslot" do
    visit timeslots_url
    click_on "New Timeslot"

    click_on "Create Timeslot"

    assert_text "Timeslot was successfully created"
    click_on "Back"
  end

  test "updating a Timeslot" do
    visit timeslots_url
    click_on "Edit", match: :first

    click_on "Update Timeslot"

    assert_text "Timeslot was successfully updated"
    click_on "Back"
  end

  test "destroying a Timeslot" do
    visit timeslots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Timeslot was successfully destroyed"
  end
end
