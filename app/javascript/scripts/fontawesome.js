//FONT AWSOME
import { config, library, dom } from '@fortawesome/fontawesome-svg-core'
config.mutateApproach = 'sync'
import { faBars, faChevronDown, faChevronUp, faXmark, faMagnifyingGlass, faGlobe } from '@fortawesome/free-solid-svg-icons'

library.add( faBars, faChevronDown, faChevronUp, faXmark, faMagnifyingGlass, faGlobe)
dom.watch()