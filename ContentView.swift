import SwiftUI

@main
struct NumberBookIOSApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView().tabItem { Label("بحث", systemImage: "magnifyingglass") }.tag(0)
            HistoryView().tabItem { Label("السجل", systemImage: "clock") }.tag(1)
            SettingsView().tabItem { Label("الإعدادات", systemImage: "gearshape") }.tag(2)
        }
        .environment(\.layoutDirection, .rightToLeft)
        .tint(.blue)
    }
}

struct SearchView: View {
    @State private var number = ""
    @State private var message = "أدخل رقم هاتف للبحث"
    @State private var didSearch = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Image(systemName: "person.crop.circle.badge.magnifyingglass")
                    .font(.system(size: 64)).foregroundStyle(.blue)
                Text("NumberBook").font(.largeTitle.bold())
                Text("البحث عن رقم هاتف").font(.headline)
                TextField("رقم الهاتف مع رمز الدولة", text: $number)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button {
                    didSearch = true
                    message = number.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        ? "يرجى إدخال رقم هاتف أولاً"
                        : "واجهة البحث جاهزة، لكن خدمة البحث الأصلية غير متصلة."
                } label: {
                    Label("بحث", systemImage: "magnifyingglass")
                        .frame(maxWidth: .infinity).padding()
                        .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white).font(.headline)
                }.padding(.horizontal)
                if didSearch {
                    Text(message).font(.subheadline).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center).padding(.horizontal)
                }
                Spacer()
                Text("لا تتم مزامنة جهات الاتصال أو إرسالها من هذا النموذج.")
                    .font(.caption).foregroundStyle(.secondary)
                    .padding(.bottom, 12)
            }
            .padding(.top, 38)
            .navigationTitle("الرئيسية")
        }
    }
}

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("لا يوجد سجل بعد",
                systemImage: "clock",
                description: Text("ستظهر عمليات البحث المحفوظة هنا بعد إضافة تخزين محلي آمن."))
                .navigationTitle("السجل")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("التطبيق") {
                    LabeledContent("الاسم", value: "NumberBook iOS")
                    LabeledContent("الحالة", value: "نسخة أولية")
                }
                Section("الخصوصية") {
                    Text("هذه النسخة لا تطلب الوصول إلى جهات الاتصال أو الرسائل، ولا تتصل بخوادم NumberBook.")
                }
                Section("ميزات تحتاج إلى تطوير") {
                    Label("ربط واجهة API موثوقة", systemImage: "network")
                    Label("سياسة الخصوصية والموافقة", systemImage: "hand.raised")
                    Label("حفظ سجل البحث محلياً", systemImage: "lock")
                }
            }
            .navigationTitle("الإعدادات")
        }
    }
}
