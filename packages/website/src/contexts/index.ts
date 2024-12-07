import { DEFAULT_THEME } from '../constants'

export {
  useActiveAnchor,
  useSetActiveAnchor,
  ActiveAnchorProvider
} from './active-anchor'
export { useConfig, ConfigProvider } from './config'
export { useMenu } from './menu'

export const useThemeConfig = () => DEFAULT_THEME
