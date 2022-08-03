import Foundation

struct SettingInfo {
    let itemName: String
    let hasIndicator: Bool
}

extension SettingInfo {
    static let defaultSettings: [SettingInfo] = [
        SettingInfo(itemName: "공지사항", hasIndicator: true),
        SettingInfo(itemName: "화면설정", hasIndicator: true),
        SettingInfo(itemName: "알림설정", hasIndicator: true),
        SettingInfo(itemName: "앱 버전", hasIndicator: true)
    ]

    static let userManageSettings: [SettingInfo] = [
        SettingInfo(itemName: "이용약관", hasIndicator: true),
        SettingInfo(itemName: "로그아웃", hasIndicator: false),
        SettingInfo(itemName: "회원탈퇴", hasIndicator: false)
    ]
}
