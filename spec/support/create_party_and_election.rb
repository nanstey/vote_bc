def party_and_election
  Party.create!([
    {name: 'BC Action Party', abbr: 'BCAP'},
    {name: 'BC Cascadia Party', abbr: 'BCC'},
    {name: 'BC Conservative Party', abbr: 'CP'},
    {name: 'BC Excalibur Party', abbr: 'BCEX'},
    {name: 'BC First', abbr: 'FP'},
    {name: 'BC Green Party', abbr: 'GP'},
    {name: 'BC Liberal Party', abbr: 'LIB'},
    {name: 'BC Marijuana Party', abbr: 'BCM'},
    {name: 'BC NDP', abbr: 'NDP'},
    {name: 'BC Party', abbr: 'BCP'},
    {name: 'BC Refed', abbr: 'REFD'},
    {name: 'BC Social Credit Party', abbr: 'SC'},
    {name: 'BC Vision Party', abbr: 'BCV'},
    {name: 'Christian Heritage Party of B.C.', abbr: 'CHP' },
    {name: 'Communist Party of BC', abbr: 'COMM'},
    {name: 'Helping Hand Party', abbr: 'HH'},
    {name: 'Independent', abbr: 'IND'},
    {name: 'Libertarian', abbr: 'LBN'},
    {name: 'National Alliance Party', abbr: 'NAP'},
    {name: 'No Affiliation', abbr: ''},
    {name: 'Other', abbr: 'OTH'},
    {name: 'Peoples Front', abbr: 'PF'},
    {name: 'Platinum Party', abbr: 'PLAT'},
    {name: 'Republican Party', abbr: 'RP'},
    {name: 'Rural BC Party', abbr: 'RU'},
    {name: 'The Advocational Party', abbr: 'AID'},
    {name: 'The Sex Party', abbr: 'SEX'},
    {name: 'The Vancouver Island Party', abbr: 'VIP'},
    {name: 'Unparty: The Consensus-Building Party', abbr: 'UCBP'},
    {name: 'Western Canada Concept Party', abbr: 'WCC'},
    {name: 'Wexit BC', abbr: 'WX'},
    {name: 'Work Less Party', abbr: 'WLP'},
    {name: 'Your Political Party of BC (YPP)', abbr: 'YPBC'}
  ])
  Election.create!([
    {year: 2020},
    {year: 2017},
    {year: 2013},
    {year: 2009}
  ])
end