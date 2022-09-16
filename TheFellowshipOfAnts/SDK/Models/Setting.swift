import Foundation

struct SettingsSection {
    let header: String
    let settings: [Setting]
}

struct Setting {
    let itemName: String
    let hasIndicator: Bool
}

extension SettingsSection {
    static let model: [SettingsSection] = [
        SettingsSection(
            header: "기본 설정",
            settings: [
                Setting(itemName: "공지사항", hasIndicator: true),
                Setting(itemName: "화면설정", hasIndicator: true),
                Setting(itemName: "알림설정", hasIndicator: true),
                Setting(itemName: "앱 버전", hasIndicator: true)
            ]),
        SettingsSection(
            header: "유저 설정",
            settings: [
                Setting(itemName: "이용약관", hasIndicator: true),
                Setting(itemName: "로그아웃", hasIndicator: false),
                Setting(itemName: "회원탈퇴", hasIndicator: false)
            ])
    ]
}
