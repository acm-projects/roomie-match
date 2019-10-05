import bs4 as bs
import urllib.request
import sys

TARGET_CITY_INDEX = 0
TARGET_STATE_INDEX = 1

target_city = sys.argv[TARGET_CITY_INDEX]   #The city to scrape the coordinates of will be passed as the first argument
target_state = sys.argv[TARGET_STATE_INDEX] #The state to scrape the coordinates of will be passed as the second argument

search_url = "https://www.wikidata.org/w/index.php?search=&search=" + target_city + "+" + target_state  #The URL that will search Wiki Data for location information

#Opening and reading the page source at search_url
source_page = urllib.request.urlopen(search_url).read()

#Creating a soup object to parse the HTML from source_page
search_page_soup = bs.BeautifulSoup(source, "lxml")
