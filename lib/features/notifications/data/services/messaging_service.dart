abstract class MessagingService {
  Future<void> init(String userId);
  Future<void> dispose();
}
