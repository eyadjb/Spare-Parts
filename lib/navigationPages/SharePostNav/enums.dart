// ignore_for_file: non_constant_identifier_names

final List<String> selectedCardModel = [
  'אאודי',
  'ב.מ.וו',
  'שברולט',
  'קרייזלר',
  'דייהטסו',
  'פורד',
  'הינו',
  'הונדה',
  'איסוזו',
  'יגואר',
  'ג\'יפ',
  'לנדרובר',
  'לקסוס',
  'מזדה',
  'מרצדס',
  'מיצובישי',
  'ניסאן',
  'פיז\'ו',
  'פורשה',
  'סובארו',
  'סוזוקי',
  'טויוטה',
  'UD',
  'פולקסווגן',
  'וולוו'
];

List<String> carManufacturersInHebrew = [
  'טויוטה',
  'יונדאי',
  'קיה',
  'מזדה',
  'ניסאן',
  'סובארו',
  'הונדה',
  'מרצדס',
  'ב.מ.וו',
  'אאודי',
  'וולוו',
  'פורד',
  'שברולט',
  'פיאט',
  'פולקסווגן',
  'סיאט',
  'סקודה',
  'פיז\'ו',
  'רנו',
  'סיטרואן'
];

final Map<String, List<String>> makeOptions = {
  'אאודי': [
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
    'Q3',
    'Q5',
    'Q7',
    'Q8',
    'R8',
    'TT',
  ],
  'ב.מ.וו': [
    '1 Series',
    '2 Series',
    '3 Series',
    '4 Series',
    '5 Series',
    '6 Series',
    '7 Series',
    '8 Series',
    'M2',
    'M3',
    'M4',
    'M5',
    'M6',
    'X1',
    'X2',
    'X3',
    'X4',
    'X5',
    'X6',
    'X7',
    'Z4',
    'i3',
    'i8',
  ],
  'שברולט': [
    'Blazer',
    'Camaro',
    'Colorado',
    'Corvette',
    'Equinox',
    'Express',
    'Malibu',
    'Silverado',
    'Suburban',
    'Tahoe',
    'Trailblazer',
    'Traverse',
    'Traverse Limited',
    'Trax',
  ],
  'קרייזלר': [
    '200',
    '300',
    'Aspen',
    'Pacifica',
    'PT Cruiser',
    'Sebring',
    'Town & Country',
    'Voyager',
  ],
  'דייהטסו': [
    'Charade',
    'Copen',
    'Materia',
    'Sirion',
    'Terios',
    'YRV',
  ],
  'פורד': [
    'Bronco',
    'EcoSport',
    'Edge',
    'Escape',
    'Everest',
    'Expedition',
    'Explorer',
    'F-150',
    'F-250',
    'Fiesta',
    'Focus',
    'Fusion',
    'Mustang',
    'Ranger',
    'Taurus',
    'Transit',
  ],
  'הינו': [
    '155',
    '195',
    '258',
    '268',
    '338',
    '358',
  ],
  'הונדה': [
    'Accord',
    'Civic',
    'City',
    'CR-V',
    'Fit',
    'HR-V',
    'Jazz',
    'Odyssey',
    'Pilot',
    'Ridgeline',
  ],
  'איסוזו': [
    'D-Max',
    'MU-X',
    'N-Series',
    'NPR',
    'NQR',
    'NRR',
  ],
  'יגואר': [
    'E-PACE',
    'F-PACE',
    'F-TYPE',
    'I-PACE',
    'XE',
    'XF',
    'XJ',
  ],
  'ג\'יפ': [
    'Cherokee',
    'Compass',
    'Gladiator',
    'Grand Cherokee',
    'Renegade',
    'Wrangler',
  ],
  'לנדרובר': [
    'Defender',
    'Discovery',
    'Discovery Sport',
    'Range Rover',
    'Range Rover Evoque',
    'Range Rover Sport',
    'Range Rover Velar',
  ],
  'לקסוס': [
    'CT',
    'ES',
    'GS',
    'GX',
    'IS',
    'LC',
    'LS',
    'LX',
    'NX',
    'RC',
    'RX',
    'UX',
  ],
  'מזדה': [
    '2',
    '3',
    '6',
    'CX-3',
    'CX-30',
    'CX-5',
    'CX-9',
    'MX-5',
  ],
  'מרצדס': [
    'A-Class',
    'B-Class',
    'C-Class',
    'CLA-Class',
    'CLS-Class',
    'E-Class',
    'G-Class',
    'GLA-Class',
    'GLB-Class',
    'GLC-Class',
    'GLE-Class',
    'GLS-Class',
    'S-Class',
    'SL-Class',
    'SLC-Class',
    'V-Class',
  ],
  'מיצובישי': [
    'ASX',
    'Eclipse Cross',
    'L200',
    'Outlander',
    'Pajero',
    'Pajero Sport',
    'Space Star',
    'Triton',
  ],
  'ניסאן': [
    '350Z',
    '370Z',
    'Almera',
    'Altima',
    'Armada',
    'Juke',
    'Kicks',
    'Leaf',
    'Maxima',
    'Murano',
    'Navara',
    'Note',
    'Pathfinder',
    'Patrol',
    'Pickup',
    'Qashqai',
    'Rogue',
    'Sentra',
    'Skyline',
    'Sylphy',
    'Tiida',
    'Titan',
    'X-Trail',
  ],
  'פיז\'ו': [
    '108',
    '208',
    '2008',
    '308',
    '3008',
    '508',
    '5008',
    'Rifter',
    'Traveller',
  ],
  'פורשה': [
    '911',
    '918 Spyder',
    'Boxster',
    'Cayenne',
    'Cayman',
    'Macan',
    'Panamera',
    'Taycan',
  ],
  'סובארו': [
    'BRZ',
    'Forester',
    'Impreza',
    'Legacy',
    'Outback',
    'WRX',
    'XV',
  ],
  'סוזוקי': [
    'Alto',
    'Baleno',
    'Celerio',
    'Ciaz',
    'Ertiga',
    'Ignis',
    'Jimny',
    'S-Cross',
    'Swift',
    'Vitara',
  ],
  'טויוטה': [
    '4Runner',
    '86',
    'Avalon',
    'C-HR',
    'Camry',
    'Corolla',
    'FJ Cruiser',
    'Fortuner',
    'Hiace',
    'Highlander',
    'Hilux',
    'Land Cruiser',
    'Prado',
    'Prius',
    'RAV4',
    'Sequoia',
    'Sienna',
    'Supra',
    'Tacoma',
    'Tundra',
    'Venza',
    'Yaris',
  ],
  'UD': [
    'Condor',
    'Quester',
    'Quon',
  ],
  'פולקסווגן': [
    'Arteon',
    'Atlas',
    'Beetle',
    'Caddy',
    'Golf',
    'ID.3',
    'ID.4',
    'Jetta',
    'Passat',
    'T-Cross',
    'T-Roc',
    'Tiguan',
    'Touareg',
    'Transporter',
  ],
  'וולוו': [
    'C30',
    'S40',
    'S60',
    'S70',
    'S80',
    'S90',
    'V40',
    'V50',
    'V60',
    'V70',
    'V90',
    'XC40',
    'XC60',
    'XC70',
    'XC90',
  ],
};

final List<String> dates = [
  "1971",
  "1972",
  "1973",
  "1974",
  "1975",
  "1976",
  "1977",
  "1978",
  "1979",
  "1980",
  "1981",
  "1982",
  "1983",
  "1984",
  "1985",
  "1986",
  "1987",
  "1988",
  "1989",
  "1990",
  "1991",
  "1992",
  "1993",
  "1994",
  "1995",
  "1996",
  "1997",
  "1998",
  "1999",
  "2000",
  "2001",
  "2002",
  "2003",
  "2004",
  "2005",
  "2006",
  "2007",
  "2008",
  "2009",
  "2010",
  "2011",
  "2012",
  "2013",
  "2014",
  "2015",
  "2016",
  "2017",
  "2018",
  "2019",
  "2020",
  "2021",
  "2022",
  "2023",
  "2024"
];
final List<String> LocationsArea = [
  "תל אביב",
  "ירושלים",
  "חיפה",
  "באר שבע",
  "אילת",
  // הוסף עוד מיקומים בהתאם לצורך
];
