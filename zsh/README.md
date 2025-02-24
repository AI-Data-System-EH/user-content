
# Pre-Configured Zsh Installation

## 설치 목록

| 항목                      | 설명                           | 비활성화 옵션 |
| ------------------------- | ------------------------------ | ------------- |
| Oh-My-Zsh & Powerlevel10k | Zsh 플러그인 설치 및 테마 설정 | `--no-omz`    |
| SSH Key                   | SSH 키 생성               | `--no-ssh`    |
| GitHub CLI                | GitHub CLI 로그인 및 키 등록   | `--no-gh`     |
| Git                       | Git 설정 (Verified Commit)     | `--no-git`    |

## 1. 설정만 설치 (일반 사용자)

### (a) 기본 설치

> `--gh-token`: GitHub CLI 설정을 위해 개인 액세스 토큰이 필요합니다. `<token>`을 복사한 토큰으로 대체해주세요.  
> 토큰 발급 절차는 아래의 [GitHub CLI 토큰 발급](#github-cli-토큰-발급)을 참고하세요.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --gh-token <token>
```

### (b) 모든 설정 재설치

> `--reinstall`: 기존 설정을 모두 삭제 및 덮어쓰고 새로운 설정으로 대체합니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --reinstall --gh-token <token>
```

### (c) GitHub CLI 설정 건너뛰기

> `--no-gh`: Git 설정은 GitHub 계정정보를 사용하지 않고 기본 사용자 정보로 설정됩니다.  
> GitHub CLI를 설치하지 않는 경우 `--gh-token` 옵션은 생략 가능합니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --no-gh
```

<br/>

## 2. 종속성만 설치 (관리자 권한 필요)

> 시스템 초기 설치 시 유용합니다. (사용자 설정이 필요없는 경우)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --deps-only
```

<br/>

## 3. 전체 설치 (종속성 포함, 관리자 권한 필요)

> 시스템 초기 패키지 설치 및 사용자 설정을 동시에 수행합니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/AI-Data-system-EH/user-content/main/zsh/install.sh)" -- --install-deps --gh-token <token>
```

<br/><br/>

## 설치 옵션

| 옵션                    | 설명                                                 |
| ----------------------- | ---------------------------------------------------- |
| `--username <username>` | GitHub Account Username (Not Profile name)           |
| `--email <email>`       | GitHub 계정에 등록된 이메일 주소                     |
| `--no-omz, --no-zsh`    | Oh-My-Zsh 및 Zsh 설치 건너뛰기                       |
| `--no-ssh`              | SSH 키 생성 건너뛰기                                 |
| `--no-git`              | Git 설정 건너뛰기                                    |
| `--no-gh`               | GitHub CLI 설정 건너뛰기                             |
| `--ssh-key-path <path>` | SSH 키 경로 (기본값: ~/.ssh/id_ed25519)              |
| `--gh-token <token>`    | GitHub 개인 액세스 토큰 (파일 경로 또는 토큰 문자열) |
| `--gh-skip-ssh-key`     | GitHub에 SSH 키 추가 건너뛰기                        |
| `--install-deps`        | 시스템 패키지 종속성 설치 (권한 필요)                |
| `--deps-only`           | 종속성만 설치 (관리자 권한 필요)                     |
| `--help, -h`            | 도움말 메시지 표시                                   |
| `--yes, -y`             | 사용자 확인 건너뛰기                                 |
| `--reinstall`           | 모든 설정 재설치                                     |

<br/><br/>

## GitHub CLI 토큰 발급

1. [GitHub Personal Access Token](https://github.com/settings/tokens) 페이지로 이동
2. `Generate new token (classic)` 버튼 클릭
3. `repo`, `read:org`, `gist`, `user`, `admin:public_key`, `admin:ssh_signing_key` 권한 선택
4. 토큰 생성 후 복사
5. 토큰을 파일로 저장하거나, 직접 전달
6. `--gh-token` 옵션으로 토큰 전달 (파일 경로 또는 토큰 문자열)
