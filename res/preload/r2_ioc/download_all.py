#!/usr/bin/env python
import requests
import codecs
base_url = 'https://docs.google.com/spreadsheet/pub?key=0AttCeOvLP6XMdG82NHZfSEJJOGdQTkgzb05aRjkzMEE'
categories = {
    'Attachment.csv'              : '%s&single=true&gid=24&output=csv'% base_url,
    'Constraint.csv'              : '%s&single=true&gid=41&output=csv'% base_url,
    'DataProcess.csv'             : '%s&single=true&gid=6&output=csv'% base_url,
    'DataProcessDefinition.csv'   : '%s&single=true&gid=3&output=csv'% base_url,
    'DataProduct.csv'             : '%s&single=true&gid=7&output=csv'% base_url,
    'DataProductLink.csv'         : '%s&single=true&gid=23&output=csv'% base_url,
    'Deployment.csv'              : '%s&single=true&gid=34&output=csv'% base_url,
    'InstrumentAgent.csv'         : '%s&single=true&gid=8&output=csv'% base_url,
    'InstrumentAgentInstance.csv' : '%s&single=true&gid=21&output=csv'% base_url,
    'InstrumentDevice.csv'        : '%s&single=true&gid=0&output=csv'% base_url,
    'InstrumentModel.csv'         : '%s&single=true&gid=4&output=csv'% base_url,
    'InstrumentSite.csv'          : '%s&single=true&gid=1&output=csv'% base_url,
    'Observatory.csv'             : '%s&single=true&gid=28&output=csv'% base_url,
    'Org.csv'                     : '%s&single=true&gid=9&output=csv'% base_url,
    'ParameterDefs.csv'           : '%s&single=true&gid=57&output=csv'% base_url,
    'ParameterDictionary.csv'     : '%s&single=true&gid=58&output=csv'% base_url,
    'ParameterFunctions.csv'      : '%s&single=true&gid=68&output=csv'% base_url,
    'Parser.csv'                  : '%s&single=true&gid=71&output=csv'% base_url,
    'PlatformDevice.csv'          : '%s&single=true&gid=11&output=csv'% base_url,
    'PlatformModel.csv'           : '%s&single=true&gid=12&output=csv'% base_url,
    'PlatformSite.csv'            : '%s&single=true&gid=19&output=csv'% base_url,
    'StreamDefinition.csv'        : '%s&single=true&gid=13&output=csv'% base_url,
    'Subsite.csv'                 : '%s&single=true&gid=10&output=csv'% base_url,
    'User.csv'                    : '%s&single=true&gid=16&output=csv'% base_url,
    'UserRole.csv'                : '%s&single=true&gid=22&output=csv'% base_url,
    'Workflow.csv'                : '%s&single=true&gid=38&output=csv'% base_url,
    'WorkflowDefinition.csv'      : '%s&single=true&gid=37&output=csv'% base_url,
}

def get(cat):
    print 'Getting ', cat
    with codecs.open(cat,'w', 'utf-8') as f:
        r = requests.get(categories[cat])
        f.write(r.text)

if __name__ == '__main__':


    import sys
    if len(sys.argv) > 1:
        for arg in sys.argv[1:]:
            if arg in categories:
                get(arg)

    else:
        for k in categories.iterkeys():
            get(k)


