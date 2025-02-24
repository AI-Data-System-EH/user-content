
# Pre-Configured Zsh Installation

## 설치 목록

| 항목          | 설명                         |
| ------------- | ---------------------------- |
| Oh-My-Zsh     | Zsh 설정 관리 프레임워크     |
| Powerlevel10k | Zsh 테마                     |
| SSH Key       | SSH 키 생성 및 GitHub에 등록 |
| GitHub CLI    | GitHub CLI 설치 및 로그인    |
| Git           | Git 설정 (Verified Commit)   |

## 전체 설치 (종속성 포함, 관리자 권한 필요)

- 기존 설치된 세팅을 새로운 설정으로 대체하려면 `--reinstall` 옵션을 추가하세요.

- `<token>`은 GitHub CLI를 사용하기 위한 개인 액세스 토큰입니다. 복사한 토큰으로 대체해주세요.

  - 토큰은 [GitHub Personal Access Token (classic)](https://github.com/settings/tokens)에서 만들 수 있습니다.
  - GitHub CLI를 설치하지 않는 경우(`--no-gh`) `--gh-token` 옵션은 생략 가능합니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --install-deps --gh-token <token>
```

## 설정만 설치 (일반 사용자)

> `sudo` 권한이 필요한 설치(`--install-deps`)는 실행되지 않습니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --gh-token <token>
```

## 설치 옵션

| 옵션                    | 설명                                                     |
| ----------------------- | -------------------------------------------------------- |
| `--username <username>` | GitHub Account Username (Not Profile name)               |
| `--email <email>`       | GitHub 계정에 등록된 이메일 주소                         |
| `--no-omz`              | Oh-My-Zsh 설치 건너뛰기                                  |
| `--no-ssh`              | SSH 키 생성 건너뛰기                                     |
| `--no-git`              | Git 설정 건너뛰기                                        |
| `--no-gh`               | GitHub CLI 설정 건너뛰기                                 |
| `--ssh-key-path <path>` | SSH 키 경로 (기본값: ~/.ssh/id_ed25519)                  |
| `--gh-token <token>`    | GitHub CLI 개인 액세스 토큰 (파일 경로 또는 토큰 문자열) |
| `--gh-skip-ssh-key`     | GitHub에 SSH 키 추가 건너뛰기                            |
| `--install-deps`        | 시스템 패키지 종속성 설치 (권한 필요)                    |
| `--help, -h`            | 도움말 메시지 표시                                       |
| `--yes, -y`             | 사용자 확인 건너뛰기                                     |
| `--reinstall`           | 모든 설정 재설치                                         |

## GitHub CLI 토큰 발급

1. [GitHub Personal Access Token](https://github.com/settings/tokens) 페이지로 이동
2. `Generate new token (classic)` 버튼 클릭
3. `repo`, `read:org`, `gist`, `user`, `admin:public_key`, `admin:ssh_signing_key` 권한 선택
4. 토큰 생성 후 복사
5. 토큰을 파일로 저장하거나, 직접 전달
6. `--gh-token` 옵션으로 토큰 전달 (파일 경로 또는 토큰 문자열)
