# Architecture

## Current Starter Architecture

```text
Flutter App
  -> Home Screen
  -> Search Placeholder
  -> Upload Placeholder
  -> Recognition Placeholder
  -> About Screen
```

## Future Architecture

```text
Flutter App
  -> Firebase Auth
  -> Firestore
  -> Firebase Storage
  -> Recognition Service
      -> MediaPipe Landmarks
      -> Similarity Matching
```

## Future Firestore Collection

Collection name:

```text
sign_videos
```

Example document:

```json
{
  "word": "hola",
  "word_key": "hola",
  "video_url": "https://example.com/video.mp4",
  "country": "Mexico",
  "region": "Colima",
  "language": "LSM",
  "uploaded_by": "Luis",
  "created_at": "timestamp",
  "status": "approved",
  "likes": 0
}
```
