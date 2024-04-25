//
//  NotificationService.swift
//  voiceMemo
//

import UserNotifications

struct NotificationService {
    func sendNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in //알임 권한설정 체크
            if granted {
                let content = UNMutableNotificationContent() //알림 내용 설정
                content.title = "타이머 종료!"
                content.body = "설정한 타이머가 종료되었습니다."
                content.sound = UNNotificationSound.default
                
                //알림 트리거 시간 설정
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                
                //알림 요청 생성
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                //요청 스케쥴러 추가
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        //알림을 화면에 표시
        completionHandler([.banner, .sound])
    }
}
