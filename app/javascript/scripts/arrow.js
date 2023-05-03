import { config, library, dom } from '@fortawesome/fontawesome-svg-core'
import {faCircleChevronLeft} from '@fortawesome/free-solid-svg-icons'
import { faCircleChevronRight } from '@fortawesome/free-solid-svg-icons';

  config.mutateApproach = 'sync'
  library.add(faCircleChevronRight,faCircleChevronLeft)
  dom.watch()
